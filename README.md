# Compas dansant (dancing dividers)

A simple Purescript application that generates random drawings using HTML Canvas.

While going through the Purescript book and in particular the [Canvas Graphics chapter](https://book.purescript.org/chapter9.html) I decided to play a bit with the provided [HTML Canvas API in Purescript](https://pursuit.purescript.org/packages/purescript-canvas/3.0.0/docs/Graphics.Canvas) and hopefully learn a bit in the process.

## Build and run

**You need [Yarn](https://yarnpkg.com/) and [Spago](https://github.com/purescript/spago) to build this.**

I used Spago as a package manager and build tool. I used Yarn because someone on the Internet insisted on using Yarn to facilitate scripting custom development actions. So the following *should* work but I wouldn't bet on it:

```shell
$ git clone https://github.com/bladyjoker/compas-dansant.git
$ cd compas-dansant
$ yarn build
$ yarn serve
```

## Fun parts

You can see the application itself in the [index.html](index.html) file. The fun part was using basic trigonometry to connect the Arcs and turn them into *connectable* things that Purescript and Haskell folks call **Monoid** and **Semigroup**.
