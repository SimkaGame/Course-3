class BankAccount:
    def __init__(self, person, number, balance):
        self.person : str = person
        self.number : str = number
        self.balance : float = balance

    #Метод пополнение
    def deposit(self, count):
        
        self.balance += count
        print (f"Счет {self.number} на имя {self.person} был пополнен на {count} рублей.\nТекущий баланс - {self.balance} рублей")

    def removing(self, count):
        if count <= self.balance:
            self.balance -= count
            print(f"Со счета {self.number} на имя {self.person} было списанно {count} рублей. \nТекущий баланс - {self.balance} рублей")
        else:
             print("Сумма списание не может быть больше текущей суммы на счету")
    
    def __str__(self) -> str:
        return f'{self.person}: {self.number}, {self.balance}'

def main():
    f1 = BankAccount('Дмитрий', '13428', 88400)    
    f1.deposit(10000)
    f1.removing(12000)
    f1.removing(1000000)
    print(f1)

if __name__ == '__main__':
        main()