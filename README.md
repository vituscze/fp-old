Functional Programming (NAIL097)
================================

Lecture on Thursday 12:10 in SU1.

Resources
---------

### Some lecture notes

- We have prepared [some lecture notes](https://github.com/vituscze/fp/blob/master/FP-lecture-notes.pdf), mostly for the Hindley-Milner type system.

### Haskell

- [Learn You a Haskell for Great Good](http://learnyouahaskell.com/)
- [Real World Haskell](http://book.realworldhaskell.org/)
- [Haskell Wikibook](https://en.wikibooks.org/wiki/Haskell)

### Lambda calculus

- [Introduction to the lambda calculus](http://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf)
- [Notes on ipmlementing lambda calculus](http://dev.stephendiehl.com/fun/003_lambda_calculus.html)
- [An easy to read blog post about reduction strategies](http://seanbowman.me/blog/lambda-calculus-reduction/)
- [A concise way of performing substitution and beta-reduction in de Bruijn representation of lambda terms](https://github.com/Gabriel439/Haskell-Morte-Library/issues/1)
- [Article on combinatory logic containing the abstraction elimination  technique discussed on the lecture (Combinatory calculi -> Completeness of the S-K basis)](https://en.wikipedia.org/wiki/Combinatory_logic)

Programming Tools
-----------------

- [Haskell Platform](https://www.haskell.org/platform/)
- ...

Requirements
------------

To complete the course, students need to pass the exam or write a program.

Exam will cover topics discussed during the semester, form of the exam (written or oral) will be determined at a later date.

The programming task involves creating a simple evaluator and a type inference engine for one of the lambda calculus variations discussed in lectures, further specifications will be given in the form of assignments during the semester.


Programming task
----------------

### Homework #1

- Choose your favorite lambda term representation and define the appropriate data type for the representation. You can choose either:
   - straightforward lambda terms representation
   - lambda terms representation using [De Bruijn indices](https://en.wikipedia.org/wiki/De_Bruijn_index) 
- Implement *substitution* and *beta-reduction*. You have two options here:
  - Implement *substitution* and *beta-reduction* directly for your representation of lambda terms. 
  - Or you can choose alternative (or bonus) approach: Avoid problems dealing with bound variables by using *abstraction elimination* to transform lambda terms to simpler combinator terms. See [wikipedia article on combinatory logic](https://en.wikipedia.org/wiki/Combinatory_logic) containing description of the *abstraction elimination* technique discussed on the lecture (section Combinatory calculi -> Completeness of the S-K basis).

- Implement the *normal reduction strategy*.

### Homework #2

- Implement Hindley-Milner algorithm W (see the [lecture notes](https://github.com/vituscze/fp/blob/master/FP-lecture-notes.pdf) for more information).

