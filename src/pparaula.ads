
with Ada.Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Text_IO, Ada.Wide_Wide_Characters.Handling;

-- Package que defineix el tipus tparaula i les operacions
-- que es poden realitzar amb ell.
--
-- Aquest package tambe defineix el tipus OrigenParaula per poder
-- fer tractaments des de fitxer i teclat independentment.
package pparaula is
   ---------------------------------------------------------
   -- Definicions publiques relacionades amb les paraules --
   ---------------------------------------------------------

   -- Nombre maxim de lletres que poden formar una paraula
   MAXIM : constant integer:= 30;
   -- Rang de llargaries que pot tenir una paraula donada
   subtype tllargaria is  integer range 0..MAXIM;
   subtype rang_lletres is tllargaria range 1..tllargaria'LAST;

   -- Definicio del tipus tparaula.
   type tparaula is private;

   -- Procediment per escriure a la pantalla
   procedure put(p : in tparaula);
   -- Procediment per escriure a un fitxer de text
   procedure put(f : in out File_Type; p : in tparaula);
   -- Funcio per comparar dues paraules i determinar si son iguals
   function "=" (a, b : in tparaula) return boolean;
   -- Funcio per saber la llargaria d'una paraula. Es a dir, el nombre
   -- de lletres que formen la paraula en questio
   function llargaria(p : in tparaula) return tllargaria;
   -- Funcio que indica si la paraula esta buida
   function buida(p : in tparaula) return boolean;
   -- Funcio que torna la lletra que es troba a una posicio determinada
   -- d'una paraula.
   function caracter(p : in tparaula; posicio : in rang_lletres) return character;

   function toString(p: in tparaula) return  String;

   ---------------------------------------------------------------------
   -- Definicions publiques relacionades amb l'origen de les paraules --
   ---------------------------------------------------------------------

   -- Procediment que copia una paraula. Es un procediment util per
   -- utilitzar aquest package PParaules i generics.
   procedure copiar(desti : out tparaula; origen : in tparaula);

   type OrigenParaules is limited private;

   -- Procediment per tractar amb les paraules llegides del teclat
   procedure open(origen : out OrigenParaules);
   -- Procediment per tractar amb les paraules llegides del fitxer nom
   procedure open(origen : out OrigenParaules; nom : in String);
   -- Procediment per tancar l'origen de les paraules
   procedure close(origen : in out OrigenParaules);
   -- Procediment per llegir una paraula des d'un origen de paraules
   procedure get(origen : in out OrigenParaules; p: out tparaula);

  

private
   --------------------------------------------------------------
   -- Declaracions privades relacionades amb el tipus tparaula --
   --------------------------------------------------------------

   -- Declaracions per declara l'array de lletres que formaran la paraula
   type taula_lletres is array (rang_lletres) of character;

   -- Declaracio privada del tipus tparaula.
   type tparaula is record
      lletres : taula_lletres;
      llargaria : tllargaria;
   end record;


   ---------------------------------------------------------------------
   -- Definicions publiques relacionades amb l'origen de les paraules --
   ---------------------------------------------------------------------
   type OrigenParaules is record
      defitxer : boolean; -- si el camp es true es llegeix de fitxer
                          -- si es false es llegeix del teclat
      fitxer : file_type; -- Si s'ha de llegir del fitxer es fa us del camp
      lletra : character; -- darrer caracter llegit
   end record;

end pparaula;
