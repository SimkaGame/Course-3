import os
from urllib.parse import unquote
from django.conf import settings
from django.http import Http404, HttpResponse, FileResponse, JsonResponse, HttpResponseForbidden
from django.shortcuts import get_object_or_404, render
from django.views.decorators.http import require_GET
from django.contrib.auth.decorators import login_required, user_passes_test

from fintech.models import Account, Statement, User


def is_teller(user):
    return user.is_authenticated and (getattr(user,"is_teller",False) or user.is_staff or user.is_superuser)

def is_admin_user(user):
    return user.is_authenticated and (getattr(user,"is_admin",False) or user.is_superuser)

def admin_required(view_func):
    return user_passes_test(lambda u: u.is_authenticated and u.is_superuser, login_url="fintech:login")(view_func)


@admin_required
@require_GET
def admin_maintenance(request):
    return HttpResponse("<h1>MAINTENANCE (fintech)</h1>")

@admin_required
@require_GET
def staging_debug(request):
    return HttpResponse("<h1>STAGING DEBUG (fintech)</h1>")

@require_GET
def crash(request):
    user = getattr(request,"user",None)
    info = user.description() if user and getattr(user,"is_authenticated",False) and hasattr(user,"description") else "anon"
    raise RuntimeError(f"CRASH: {info} | DEBUG={getattr(settings,'DEBUG',None)}")

@login_required
@require_GET
def account_view(request, account_id:int):
    acc = get_object_or_404(Account, pk=account_id)
    if not (is_admin_user(request.user) or acc.owner == request.user):
        return HttpResponseForbidden("Access denied")
    return JsonResponse({"id":acc.id,"number":acc.number,"owner":str(acc.owner)})

@login_required
@require_GET
def download_statement_vuln(request, statement_id:int):
    st = get_object_or_404(Statement, pk=statement_id)
    if not (is_admin_user(request.user) or st.account.owner == request.user):
        return HttpResponseForbidden("Access denied")
    try:
        fp = st.file.path
        return FileResponse(open(fp,"rb"), as_attachment=True, filename=st.filename or os.path.basename(fp))
    except:
        raise Http404("File not found")

@login_required
@require_GET
def export_user_profile(request, user_id:int):
    if request.user.id != user_id and not is_admin_user(request.user):
        return HttpResponseForbidden("Access denied")
    u = get_object_or_404(User, pk=user_id)
    return JsonResponse({"id":u.id,"username":u.get_username(),"email":u.email})

@login_required
@require_GET
def download_by_token(request):
    token = unquote(request.GET.get("token","") or "")
    SIMPLE_TOKEN_MAP = {"stmt_1":"statements/1/stmt1.pdf","backup":"backups/bank_dump.sql"}
    target = SIMPLE_TOKEN_MAP.get(token)
    if not target: raise Http404("Not found")
    mr = getattr(settings,"MEDIA_ROOT",None)
    if not mr: raise Http404("Server misconfigured")
    full = os.path.normpath(os.path.join(mr,target))
    if not full.startswith(os.path.normpath(mr)) or not os.path.exists(full):
        raise Http404("File not found")
    return FileResponse(open(full,"rb"), as_attachment=True, filename=os.path.basename(full))

@login_required
def accounts_list(request):
    if not is_teller(request.user): return HttpResponseForbidden("Access denied")
    if is_admin_user(request.user):
        qs = Account.objects.all().order_by("-id")
    else:
        qs = Account.objects.filter(owner=request.user).order_by("-id")
    return render(request, "fintech/list.html", {"accounts":qs})

@login_required
def account_detail(request, account_id:int):
    acc = get_object_or_404(Account, pk=account_id)
    if not (is_admin_user(request.user) or is_teller(request.user) or acc.owner==request.user):
        return HttpResponseForbidden("Access denied")
    statements = acc.statements.all().order_by("-created_at")
    return render(request, "fintech/detail.html", {"account":acc,"statements":statements})

@login_required
def download_statement(request, statement_id:int):
    st = get_object_or_404(Statement, pk=statement_id)
    allowed = hasattr(st,"is_accessible_by") and st.is_accessible_by(request.user) or is_admin_user(request.user) or st.account.owner==request.user or is_teller(request.user)
    if not allowed: return HttpResponseForbidden("Access denied")
    try: path = st.file.path
    except: raise Http404("File not available")
    if not os.path.exists(path): raise Http404("File not found")
    return FileResponse(open(path,"rb"), as_attachment=True, filename=st.filename or os.path.basename(path))

@login_required
def admin_dashboard(request):
    if not is_admin_user(request.user): return HttpResponseForbidden("Access denied")
    accounts = Account.objects.all()
    return render(request,"fintech/admin_dashboard.html",{"accounts":accounts})

@login_required
def index(request):
    ctx = {"is_teller": is_teller(request.user), "is_admin": is_admin_user(request.user), "username": request.user.get_username()}
    return render(request,"fintech/index.html",ctx)
