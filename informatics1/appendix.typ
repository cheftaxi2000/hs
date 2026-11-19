#import "lib.typ": *
#set heading(numbering: none)
#show heading.where(level: 2): it => block(sticky: true, above: 1.8em, below: 0.9em, text(font: sans, size: 14.5pt, weight: "bold", it.body))

= Appendix: C++ Reference Sheet

#nolec

#lecture[A compact collection of the facts that are needed over and over. For explanations, see the chapters indicated.]

== Fundamental types (Chapters 2, 8)

#table(columns: (auto, auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Type*], [*Size (typical)*], [*Range / remark*],
  [`bool`], [1 byte], [`true`, `false`],
  [`char`], [1 byte], [one character, $-128 .. 127$ (ASCII 0-127)],
  [`int`], [4 bytes], [$-2^31 .. 2^31 - 1$ ($approx plus.minus 2.1 dot 10^9$)],
  [`unsigned int`], [4 bytes], [$0 .. 2^32 - 1$; wraps modulo $2^32$],
  [`long`], [8 bytes], [$-2^63 .. 2^63 - 1$],
  [`float`], [4 bytes], [about 7 decimal digits],
  [`double`], [8 bytes], [about 16 decimal digits, up to $approx 1.8 dot 10^308$],
  [`std::string`], [], [`#include <string>`],
  [`std::vector<T>`], [], [`#include <vector>`])

== Operators by priority (Chapter 2)

#table(columns: (auto, 1fr, auto), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Priority*], [*Operators*], [*Associativity*],
  [1 (highest)], [`::` scope, `a.b` `a->b` `a[i]` `f(x)` `a++` `a--`], [left],
  [2], [`++a` `--a` `+a` `-a` `!a` `~a` `*p` `&x` `new` `delete` `(T)x`], [right],
  [3], [`*` `/` `%`], [left],
  [4], [`+` `-`], [left],
  [5], [`<<` `>>` (shift; also stream operators)], [left],
  [6], [`<` `<=` `>` `>=`], [left],
  [7], [`==` `!=`], [left],
  [8], [`&`], [left],
  [9], [`^`], [left],
  [10], [`|`], [left],
  [11], [`&&`], [left],
  [12], [`||`], [left],
  [13 (lowest)], [`?:` `=` `+=` `-=` `*=` `/=` `%=`], [right])

== Statements (Chapters 3, 4)

#snip("if (c) { ... } else if (d) { ... } else { ... }
while (c) { ... }
do { ... } while (c);
for (int i = 0; i < n; ++i) { ... }
switch (x) { case 1: ...; break; case 2: ...; break; default: ...; }
break;  continue;  return value;")

== Functions (Chapters 4, 5, 6)

#snip("int f(int a, double b);                 // declaration (prototype)
int f(int a, double b) { ... return 0; }    // definition
void g(int& x);                             // reference: g may change the argument
int h(const std::vector<int>& v);           // const reference: read only, no copy
double p(double x, int n = 2);              // default argument
int f(double x);                            // overloading: same name, other parameter types")

== Pointers and memory (Chapter 11)

#snip("int* p = &a;          // pointer to a        *p: the value (dereference)
p->member            // same as (*p).member
int* a = new int[n]; // array on the heap   ...   delete[] a;
Node* q = new Node{v, nullptr};             ...   delete q;
p = nullptr;         // points to nothing; never dereference it")

== Classes (Chapters 10, 12, 14)

#snip("class T : public Base {                     // inheritance: T is a Base
public:
    T(int x) : Base(x), m_(x) {}             // constructor, initialiser list
    virtual ~T() {}                          // virtual destructor (base classes)
    T(const T& o);                           // copy constructor      \\
    T& operator=(const T& o);                // copy assignment        > rule of three
    ~T();                                    // destructor            /
    int get() const { return m_; }           // const member function
    virtual void f() override;               // overrides Base::f
private:
    int m_;
};")

== Frequently used library functions

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Header*], [*Contents*],
  [`<iostream>`], [`std::cin`, `std::cout`, `std::endl`],
  [`<cmath>`], [`std::sqrt`, `std::pow`, `std::fabs`, `std::sin`, `std::cos`, `std::exp`, `std::log`, `std::floor`, `std::ceil`],
  [`<cassert>`], [`assert(cond)`],
  [`<string>`], [`length()`, `substr(p, n)`, `find(t)`, `+`, `==`, `std::getline(std::cin, s)`],
  [`<vector>`], [`size()`, `push_back(x)`, `pop_back()`, `back()`, `empty()`, `clear()`, `at(i)`, `begin()`, `end()`],
  [`<algorithm>`], [`sort`, `find`, `count`, `reverse`, `min_element`, `max_element`, `binary_search`, `std::min`, `std::max`, `std::swap`],
  [`<numeric>`], [`std::accumulate`],
  [`<map>` `<set>` `<list>`], [`std::map<K, V>`, `std::set<T>`, `std::list<T>`],
  [`<stack>` `<queue>`], [`std::stack<T>` (`push`, `top`, `pop`), `std::queue<T>` (`push`, `front`, `pop`)],
  [`<limits>`], [`std::numeric_limits<int>::max()`],
  [`<iomanip>`], [`std::setprecision(n)`, `std::setw(n)`],
  [`<bitset>`], [`std::bitset<8>(x)` to print bits])

== Decision aids

#table(columns: (1fr, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Situation*], [*Use*],
  [a counted loop], [`for`],
  [repeat until something changes], [`while`],
  [body must run at least once], [`do`-`while`],
  [parameter, small type, only read], [by value: `int x`],
  [parameter, big type, only read], [`const T& x`],
  [parameter, must be modified], [`T& x`],
  [a sequence of values], [`std::vector<T>`],
  [dictionary / counting by name], [`std::map<K, V>`],
  [unique, sorted values], [`std::set<T>`],
  [object owns memory], [rule of three, or use `std::vector` / `std::string` members],
  [objects of several kinds used uniformly], [virtual functions, pointers or references to the base class])

== Typical errors at a glance

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Symptom*], [*Likely cause*],
  [`expected ';' before ...`], [missing semicolon in the line *above*],
  [`'cout' was not declared`], [missing `std::` or `#include <iostream>`],
  [wrong result of a division], [integer division: one operand must be `double`],
  [`if (a = 5)` is always true], [`=` instead of `==`],
  [loop never ends], [missing update, wrong condition, `double` counter],
  [wrong last / first element], [off-by-one: `<` vs `<=`, index from 0],
  [garbage values, crash], [uninitialised variable, `v[i]` out of range, dangling pointer],
  [crash at the end of the program], [double `delete`, missing copy constructor (rule of three)],
  [memory use grows], [leak: `new` without `delete`],
  [stack overflow], [recursion without (reachable) base case],
  [`b` in `b = a` not changed], [call by value instead of reference],
  [derived version not called], [function not `virtual`, or object passed by value (slicing)])
