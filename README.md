
# Berkeley [cs61a Spring 2011](https://wla.berkeley.edu/~cs61a/sp11/) Computer Science Course

This repo attempts to archive all the material publicly available for the cs61a 
spring 2011 course done at Berkeley by [Brian Harvey](https://people.eecs.berkeley.edu/~bh/). 
The course has moved on to use Python but in 2011 the course used a customization 
of Lisp. At one point Berkeley had a webcast program that made publicly available 
course lectures. In 2015 they decided to [discontinue the public availability of course lectures](https://web.archive.org/web/20180611205119/https://www.ets.berkeley.edu/news/fall-2015-changes-course-capture-webcast-service) 
in order to reduce costs. They offered this content on different platforms and 
in 2017 have decided to remove legacy content [away from public access due to various legal issues](https://web.archive.org/web/20181001052907/https://news.berkeley.edu/2017/03/01/course-capture/). 
Also see this [reddit post](https://www.reddit.com/r/learnprogramming/comments/5x3ihz/uc_berkeley_to_remove_free_lecture_videos_from/) 
and this [FAQ post on legacy content](https://web.archive.org/web/20180901033254/https://news.berkeley.edu/2017/02/24/faq-on-legacy-public-course-capture-content/). 

The course is based on the book Structure and Interpretation of Computer Programs a.k.a. SICP. 
Course prerequisite, as you will hear in lecture 1, is being comfortable with 
and being able to write recursive functions. If you need a quick primer on recursion 
[look at cs61as week 0](https://web.archive.org/web/20151002235812/http://www.cs61as.org/textbook/lesson-0.3-intro.html). 
I was made aware of the course through the website [teachyourselfcs.com](https://teachyourselfcs.com). 
If you find this course to be too difficult look below for alternative courses. 

If you want to learn based on the book Structure and Interpretation of Computer Programs 
but instead of Lisp you are interested in using Python 3 check out 
[Composing Programs](http://www.composingprograms.com/). 


## Getting started

### Installing Racket locally on your computer

[Download](https://download.racket-lang.org/) Racket. At the time of this writing (03.2019) 
I am using version 7.2. Open up Racket and navigate to "File" -> "Package Manager". 
Inside the package manager we will download some dependencies to be able to use 
Berkeley defined functions such as [word](https://docs.racket-lang.org/manual@simply-scheme/#%28form._%28%28lib._simply-scheme%2Fmain..rkt%29._word%29%29) 
and [sentence](https://docs.racket-lang.org/manual@simply-scheme/#%28form._%28%28lib._simply-scheme%2Fmain..rkt%29._sentence%29%29) 
as demonstrated in lecture 1. Select the tab "Available from Catalog". On the 
left hand side you will see the button "Update Package List", click it. After the 
update is complete search for the package `planet-dyoo-simply-scheme1`. Select the 
package and click the "Install" button at the bottom of the window. Next search 
for the package `berkeley` as description the package should say that it is for 
the class `cs61as`. Now close the package manager and navigate to "File" -> "New". 
At the bottom of the screen click the toggle button "Determine language from source" -> "Choose Language". 
Choose "The Racket Language" and click "OK". Now you should see a [window with two boxes](https://docs.racket-lang.org/drracket/interface-essentials.html) 
\- at the top the *definitions window* and on the bottom the *interactions window*. 

Inside the *definitions window* should be:
```
#lang racket
```
Add the line:
```
(require berkeley)

(sentence 'hello 'world)
```
Now click the button "Run" and inside of the *interactions window* should be printed
```
'(hello world)
```

If you are more of the type that prefers working with the command line you can use
the `raco` [Racket command line tool](https://docs.racket-lang.org/pkg/cmdline.html). 
To set it up on your system simple navigate to "Help" -> "Configure command line 
for Racket". After setting this up open up a command line and type in the following:
```
raco pkg install --auto berkeley
```
and 
```
raco pkg install --auto planet-dyoo-simply-scheme1
```

If you are having difficulties with installing packages you can also translate the original
library files [local](code/src/ucb/bscheme) or [online](https://wla.berkeley.edu/~scheme/source/src/ucb/bscheme/)
from Scheme to Racket.


### I want to install the original Berkeley UCB Scheme Stk used in the lectures
It is available [here](https://wla.berkeley.edu/~scheme/source/).


## [Video lectures](https://archive.org/details/ucberkeley-webcast-PL3E89002AA9B9879E?&sort=-titleSorter) and required corresponding reading from SICP

Readings should be done before lecture series.

1. Functional programming (1.1)
2. Functional programming (1.1)
3. Higher-order procedures (1.3)
4. Higher-order procedures (1.3)
5. User interface Alan Kay (1.3)
6. User interface Alan Kay (1.2.1–4)
7. Orders of growth (1.2.1–4)
8. Recursion and iteration (1.2.1–4)
9. Data abstraction (2.1, 2.2.1)
10. Sequences (2.1, 2.2.1)
11. Example calculator (2.1, 2.2.1)
12. Hierarchical data (2.2.2–3, 2.3.1,3)
13. Hierarchical data (2.2.2–3, 2.3.1,3)
14. Example Scheme (2.2.2–3, 2.3.1,3)
15. No lecture available
16. Generic operators (2.4–2.5.2)
17. Generic operators (2.4–2.5.2)
18. Object-oriented programming (OOP (reader))
19. Object oriented programming (OOP (reader))
20. Object oriented programming (OOP (reader))
21. Assignment and state (3.1, 3.2)
22. Environments (3.1, 3.2)
23. Environments (3.1, 3.2)
24. Mutable data (3.3.1–3)
25. Mutable data (3.3.1–3)
26. Vectors (3.3.1–3)
27. No lecture available
28. No lecture available
29. No lecture available
30. Client-server programming (3.4)
31. Concurrency (3.4)
32. Concurrency (3.4)
33. Streams (3.5.1–3, 3.5.5, Therac (reader))
34. Streams (3.5.1–3, 3.5.5, Therac (reader))
35. Therac-25 (3.5.1–3, 3.5.5, Therac (reader))
36. Metacircular evaluator (4.1.1–6)
37. Metacircular evaluator (4.1.1–6)
38. Mapreduce  (4.1.1–6)
39. Mapreduce (4.1.7, 4.2)
40. Analyzing evaluator (4.1.7, 4.2)
41. Lazy evaluator (4.1.7, 4.2)
42. Logic programming (4.4.1–3)
43. Logic programming (4.4.1–3)
44. Review (4.4.1–3)


 ## Course Documents
* Course Book - Structure and Interpretation of Computer Programs [online](http://sarabander.github.io/sicp/) or [online](https://web.archive.org/web/20110720003551/http://www-mitpress.mit.edu/sicp/sicp.html)
* Course syllabus [local](docs/course_syllabus.pdf) or [online](https://wla.berkeley.edu/~cs61a/sp11/0.pdf)
* Course Reader - Volume 1 [local](docs/course_reader_vol_1) or [online](https://wla.berkeley.edu/~cs61a/reader/vol1.html)
  * Homework assignments [local](docs/course_reader_vol_1/homework_assignments.pdf) or [online](http://wla.berkeley.edu/~cs61a/reader/nodate-hw.pdf)
  * Lab assignments [local](docs/course_reader_vol_1/lab_assignments.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/nodate-labs.pdf)
  * Projects
    * Project 1 - twenty-one [local](docs/course_reader_vol_1/project_1_twenty-one.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/nodate-21.pdf)
      * Code [local](code/projects/project_1_twenty-one) or [online](https://wla.berkeley.edu/~cs61a/reader/twenty-one.scm)
    * Project 2 - Section 2.2.4 out of SICP Example: A Picture Language [online](http://sarabander.github.io/sicp/html/2_002e2.xhtml#g_t2_002e2_002e4) or [online](https://web.archive.org/web/20110717164938/http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.4)
    * Project 3 - Adventure Game [local](docs/course_reader_vol_1/project_3_adventure-game.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/nodate-adv.txt)
      * Code [local](code/projects/project_3_adventure-game)
    * Project 4 - Logo interpreter [local](docs/course_reader_vol_1/project_4_logo-interpreter.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/nodate-logo.txt)
      * Code [local](code/projects/project_3_logo-interpreter)
* Course Reader - Volume 2 [local](docs/course_reader_vol_2) or [online](https://wla.berkeley.edu/~cs61a/reader/vol2.html)
  * Object-Oriented Programming: Above the Line View [local](docs/course_reader_vol_2/oop_programming_above_line_view.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/aboveline.pdf)
    * Reference Manual for the OOP Language [local](docs/course_reader_vol_2/oop_programming_reference_manual.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/ref-man.pdf)
  * Object-Oriented Programming: Below the Line View [local](docs/course_reader_vol_2/oop_programming_below_line_view.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/belowline.pdf)
  * Highlights of GNU Emacs (Prof. Paul Hilfinger, UCB EECS) [local](docs/course_reader_vol_2/highlights_of_gnu_emacs.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/gnuemacs.pdf)
    * Emacs Quick Reference Guide (Prof. Paul Hilfinger, UCB EECS) [local](docs/course_reader_vol_2/emacs_quick_reference_guide.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/quick.pdf)
  * Exit Information (Read at end of semester!) [local](docs/course_reader_vol_2/exit_information.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/exit.pdf)
  * An Investigation of the Therac-25 Accidents (Nancy G. Leveson, Clark S. Turner. IEEE Computer, July 1993) [local](docs/course_reader_vol_2/an_investigation_of_therac-25_accidents.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/Therac-25.pdf)
  * Revised5 Report on Scheme (Richard Kelsey, William Clinger, Jonathan Rees (Editors), et al., 1998) [local](docs/course_reader_vol_2/revised-5_report_on_scheme.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/r5rs.pdf)
  * Sample Exams
    * These exams are made up of actual past exam questions, but reorganized to make 
each sample more comprehensive and to choose the best possible questions. Some of 
the exams are a little longer (by one question) than actual exams, but they're in 
the right ballpark. Since the questions within a sample are taken from different 
semesters, don't try to compare the number of points between problems. The solutions 
include scoring information only to give you an idea of how part credit is awarded 
within each problem.
    * Midterm 1
      * Sample exam 1 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt1-1.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/mt1-1.pdf)
        * Solutions to sample exam 1 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt1-1_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/mt1-1.soln.txt)
      * Sample exam 2 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt1-2.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/mt1-2.pdf)
        * Solutions to sample exam 2 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt1-2_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/mt1-2.soln.txt)
      * Sample exam 3 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt1-3.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/mt1-3.pdf)
        * Solutions to sample exam 3 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt1-3_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/mt1-3.soln.txt)
    * Midterm 2
      * Sample exam 1 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt2-1.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/mt2-1.pdf)
        * Solutions to sample exam 1 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt2-1_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/mt2-1.soln.txt)
      * Sample exam 2 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt2-2.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/mt2-2.pdf)
        * Solutions to sample exam 2 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt2-2_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/mt2-2.soln.txt)
      * Sample exam 3 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt2-3.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/mt2-3.pdf)
        * Solutions to sample exam 3 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt2-3_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/mt2-3.soln.txt)
    * Midterm 3
      * Sample exam 1 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt3-1.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/mt3-1.pdf)
        * Solutions to sample exam 1 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt3-1_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/mt3-1.soln.txt)
      * Sample exam 2 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt3-2.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/mt3-2.pdf)
        * Solutions to sample exam 2 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt3-2_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/mt3-2.soln.txt)
      * Sample exam 3 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt3-3.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/mt3-3.pdf)
        * Solutions to sample exam 3 [local](docs/course_reader_vol_2/sample_exams/midterm_1/mt3-3_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/mt3-3.soln.txt)
    * Final exam
      * Sample exam 1 [local](docs/course_reader_vol_2/sample_exams/midterm_1/f-1.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/f-1.pdf)
        * Solutions to sample exam 1 [local](docs/course_reader_vol_2/sample_exams/midterm_1/f-1_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/f-1.soln.txt)
      * Sample exam 2 [local](docs/course_reader_vol_2/sample_exams/midterm_1/f-2.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/f-2.pdf)
        * Solutions to sample exam 2 [local](docs/course_reader_vol_2/sample_exams/midterm_1/f-2_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/f-2.soln.txt)
      * Sample exam 3 [local](docs/course_reader_vol_2/sample_exams/midterm_1/f-3.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/f-3.pdf)
        * Solutions to sample exam 3 [local](docs/course_reader_vol_2/sample_exams/midterm_1/f-3_solutions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/f-3.soln.txt)
  * Mapreduce: Simplified Data Processing on Large Clusters (Jeffrey Dean, Sanjay Ghemawat, Google, Inc., OSDI 2004) [local](docs/course_reader_vol_2/mapreduce_simplified_data_processing_on_large_clusters.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/mapreduce-osdi04.pdf)
  * Lecture Notes [local](docs/course_reader_vol_2/lecture_notes.pdf) or [online](https://wla.berkeley.edu/~cs61a/reader/notes.pdf)
  * SICP Errata (Harold Abelson, Gerald Jay Sussman, Julie Sussman, 1999) [local](docs/course_reader_vol_2/sicp_errata.txt4D) or [online](https://wla.berkeley.edu/~cs61a/reader/sicp-errata.txt4D)
  * Berkeley Word/Sentence Functions [local](docs/course_reader_vol_2/berkeley_word_sentence_functions.txt) or [online](https://wla.berkeley.edu/~cs61a/reader/word.txt)
  * Ergonomic Information (external links)
    * Computer Workstation Ergonomics (CDC) [online](https://web.archive.org/web/20071225030844/http://www.cdc.gov/od/ohs/Ergonomics/compergo.htm)
    * Ergonomics for Computer Workstations (NIH DOHS) [online](https://web.archive.org/web/20110408004127/http://dohs.ors.od.nih.gov/ergo_computers.htm)
* [Answers to assignments done by another student](https://github.com/fgalassi/cs61a-sp11)


## Other beginning level classes and resources involving Lisp if this course deams to be too difficult
* [How to Design Programs](https://htdp.org/2019-02-24/index.html)
* [Simply Scheme: Introducing Computer Science](https://people.eecs.berkeley.edu/~bh/ss-toc2.html)
* [An Introduction to Programming in Emacs Lisp](https://www.gnu.org/software/emacs/manual/pdf/eintr.pdf)
* [CS 61AS - a self-paced introductory computer science class at the University of California, Berkeley](https://web.archive.org/web/20150809062102/http://cs61as.org/) or [here](http://berkeley-cs61as.github.io)


## Other classes and resources for computer science
* [Teach Yourself Computer Science](https://teachyourselfcs.com)
* [A Self-Learning, Modern Computer Science Curriculum](https://functionalcs.github.io/curriculum/)
* [Open Source Society University - Path to a free self-taught education in Computer Science!](https://github.com/ossu/computer-science)
* [edX Computer Science](https://www.edx.org/course/subject/computer-science)
* [Composing Programs](http://www.composingprograms.com/)
* [Papers from the computer science community to read and discuss.](https://github.com/papers-we-love/papers-we-love)
* [MIT OpenCourseWare](https://ocw.mit.edu/index.htm)
* [openHPI](https://open.hpi.de/courses)
* [tele-TASK](https://www.tele-task.de/)
* [miniKanren - an embedded Domain Specific Language for logic programming](http://minikanren.org/)
