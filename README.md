# pH-Calculator

This application is designed to calculate the pH value of a solution. It is aimed to be a user-friendly tool so that the
you can escape the process of searching tables for the dissociation constants, analyzing the property of the solution,
and finally calculating the pH value.

## Screenshots

<div style="float:left;border:solid 1px 000;margin:10px;">
    <img src="https://github.com/mizu-bai/pH-Calculator/raw/master/README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202021-03-30%20at%2014.30.07.png" alt="Single Solution Screenshot" title="Single Solution"  width="207" height="484">
</div>

<div style="float:left;border:solid 1px 000;margin:10px;">
    <img src="https://github.com/mizu-bai/pH-Calculator/raw/master/README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202021-03-30%20at%2014.30.09.png" alt="Mixed Solution Screenshot" title="Mixed Solution" width="207" height="484">
</div>

<div style="float:left;border:solid 1px 000;margin:10px;">
    <img src="https://github.com/mizu-bai/pH-Calculator/raw/master/README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202021-03-30%20at%2014.30.12.png" alt="Armphiprotic Solution Screenshot" title="Armphiprotic Solution" width="207" height="484">
</div>

<div style="float:left;border:solid 1px 000;margin:10px;">
    <img src="https://github.com/mizu-bai/pH-Calculator/raw/master/README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202021-03-30%20at%2014.30.16.png" alt="Acid-Base Buffer Solution Screenshot" title="Acid-Base Buffer Solution" width="207" height="484">
</div>

<div style="float:left;border:solid 1px 000;margin:10px;">
    <img src="https://github.com/mizu-bai/pH-Calculator/raw/master/README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202021-03-30%20at%2014.30.20.png" alt="Dissociation Constant" width="207" height="484">
</div>

<div style="float:none;clear:both;">
    <!--Blank-->
</div>

## Which Solution Types are Supported

1. Single acid or base solution: monoprotic, diproticand, and triprotic; if an acid or base can provide or accept more
   than three protons, it will be dealt as triprotic acid or base;

2. Mixed solution: acid & acid, base & base, and acid & base;

3. Amphiprotic solution: amphiprotic salt, salt formed by weak acid and weak base, and amino acid;

4. Acid-base buffer solution: a solution contains a weak acid and its salt formed with another strong base, and vice
   versa.

## How to Input the Parameters of a Solution

You can input the parameters of a solution manually, including the dissociation constant value(s) and the concentration.
For dissolution constant, both `K` and `pK` are supported. When it comes to a polyprotic solution, input the dissolution
constants by order and it will work. For concentration `c`, the unit is mole per liter.

Also, a dissociation constant database is built in this app for you.
