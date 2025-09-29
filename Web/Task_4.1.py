from functools import wraps

def count_calls(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        wrapper.calls += 1
        return func(*args, **kwargs)
    wrapper.calls = 0
    return wrapper

@count_calls
def greet(name):
    return f"Hello, {name}!"

def main():
    print(greet("Danila"))
    print(greet("World"))
    print(greet.calls)

if __name__ == "__main__":
    main()