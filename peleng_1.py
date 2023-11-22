#1.
class First:

    letter = 'A'

    def getClassname(self):
        print('First')

    def getLetter(self):
        print(self.letter)


class Second(First):

    letter = 'B'

    def getClassname(self):
        print('Second')


obj_first = First()
obj_second = Second()

obj_first.getClassname()
obj_first.getLetter()

obj_second.getClassname()
obj_second.getLetter()

