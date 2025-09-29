from functools import wraps

def clamp_result(min_value=None, max_value=None):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            result = func(*args, **kwargs)
            if min_value is not None and result < min_value:
                return min_value
            if max_value is not None and result > max_value:
                return max_value
            return result
        return wrapper
    return decorator


@clamp_result(min_value=0, max_value=100)
def score(raw):
    return raw

def main():
    print(score(-5))    # 0
    print(score(150))   # 100
    print(score(42))    # 42

if __name__ == "__main__":
    main()