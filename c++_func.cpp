

// to tell if a object pointer is a specific type
template <class DstType, class SrcType>
bool IsType(const SrcType* src)
{
  return dynamic_cast<const DstType*>(src) != nullptr;
}


//any function as parameter
#include<iostream>
#include <functional>
using namespace std;

void foo() { std::cout << "foo" << std::endl; }
void bar( int x ) { std::cout << "bar(" << x << ")" << std::endl; }
struct test {
   void foo() { std::cout << "test::foo" << std::endl; }
};
void call( int times, std::function< void() > f )
{
   for ( int i = 0; i < times; ++i )
      f();
}
int main() {
   call( 1, &foo );                   // no need to bind any argument
   call( 2, std::bind( &bar, 5 ) );
   test t;
   call( 1, std::bind( &test::foo, &t ) ); // note the &t
   call( 1, std::bind( &test::foo, &t ) ); // note the &t
}
