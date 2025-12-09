n = int(input())
a = list(map(int, input().split()))

m = int(input())
best = [10**9] * 1001

for _ in range(m):
    b, c = map(int, input().split())
    best[b] = min(best[b], c)

for p in range(999, 0, -1):
    best[p] = min(best[p], best[p+1])

ans = 0
for need in a:
    ans += best[need]

print(ans)