import 'package:flutter_test/flutter_test.dart';
class Math {
  int add(int a, int b) {
    return a + b;
  }
}

void main(){
  group('Math', ()
  {
    Math math = Math();

    test('addingtwo numbers', () {
      expect(math.add(2, 4), 6);
    });
    //   test('adding negative numbers', (){
    //     expect(math.add(-2, -3), 1);
    //     expect(math.add(2,-3), -1);
    //     expect(math.add(-2,-3), -5);
    //   });
    // });
  });
}


