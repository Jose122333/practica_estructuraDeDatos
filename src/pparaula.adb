

package body pparaula is

      ---------------------------------------------------------
   -- Implementacions privades relacionades amb les paraules --
   ---------------------------------------------------------

   -- Procediment per escriure a la pantalla
   procedure put(p : in tparaula) is
      n: Integer := 1;
   begin
      while n <= p.llargaria loop
         put(p.lletres(n));
         n := n + 1;
      end loop;

   end put;

   -- Procediment per escriure a un fitxer de text
   procedure put(f : in out File_Type; p : in tparaula) is
      n : Integer := 1;
   begin
      while n <= p.llargaria loop
         put(f,p.lletres(n));
         n := n + 1;
      end loop;
   end put;

   -- Funcio per comparar dues paraules i determinar si son iguals
   function "=" (a, b : in tparaula) return boolean is
      igual : Boolean := True;
      n : Integer := 1;
   begin
      if a.llargaria = b.llargaria then
         while n <= a.llargaria and igual = True loop
            if a.lletres(n) = b.lletres(n) then
               null;
            else
               igual := False;
            end if;
            n := n + 1;
         end loop;
      else
         igual := False;
      end if;
      return igual;
   end "=";

   -- Funcio per saber la llargaria d'una paraula. Es a dir, el nombre
   -- de lletres que formen la paraula en questio
   function llargaria(p : in tparaula) return tllargaria is
   begin
      return p.llargaria;

   end llargaria;

   -- Funcio que indica si la paraula esta buida
   function buida(p : in tparaula) return boolean is

      begin
      return p.llargaria = 0;
      end buida;

   -- Funcio que torna la lletra que es troba a una posicio determinada
   -- d'una paraula.
   function caracter(p : in tparaula; posicio : in rang_lletres) return character is
   begin

      return p.lletres(posicio);
   end caracter;

   --Funcio que torna un string de la paraula
   function toString(p: in tparaula) return  String is

      s : String(1..p.llargaria);
   begin
      for I in p.lletres'Range loop
         s := s & p.lletres(I) ;

      end loop;

   return s;

   end toString;

      -- Procediment que copia una paraula. Es un procediment util per
   -- utilitzar aquest package PParaules i generics.
   procedure copiar(desti : out tparaula; origen : in tparaula) is
   longitudActual: Integer := 1;
   begin
      while longitudActual < origen.llargaria loop
         desti.lletres(longitudActual) := origen.lletres(longitudActual);
         longitudActual:=longitudActual+1;
      end loop;
   end copiar;

   ---------------------------------------------------------------------
   -- Implementacions privades relacionades amb l'origen de les paraules --
   ---------------------------------------------------------------------



   -- Procediment per tractar amb les paraules llegides del teclat
   procedure open(origen : out OrigenParaules) is
   begin
      origen.defitxer := false;
   end open;

   -- Procediment per tractar amb les paraules llegides del fitxer nom
   procedure open(origen : out OrigenParaules; nom : in String) is
   begin
      Open(origen.fitxer, Mode => In_File, Name => nom);
      origen.defitxer := true;
   end open;

   -- Procediment per tancar l'origen de les paraules
   procedure close(origen : in out OrigenParaules) is
   begin
      if origen.defitxer = True then
         Close(origen.fitxer);
      end if;
   end close;

   -- Procediment per llegir una paraula des d'un origen de paraules
   procedure get(origen : in out OrigenParaules; p: out tparaula) is
      longitudActual: Integer := 1;
      ActualCharacter: character := ' ';
   begin
      if origen.defitxer=True then
         Get(origen.fitxer,ActualCharacter);
         while ActualCharacter/= ' ' and ActualCharacter /= '.' loop
            p.lletres(longitudActual) := ActualCharacter;
            longitudActual:=longitudActual + 1;
            Get(origen.fitxer,ActualCharacter);
         end loop;
         p.lletres(longitudActual) := ActualCharacter;
         longitudActual:=longitudActual -1;
         p.llargaria:= longitudActual;
      else
         Put_Line("Insertar palabra");
         Get(ActualCharacter);
         while ActualCharacter/= ' ' and ActualCharacter /= '.' loop
            p.lletres(longitudActual) := ActualCharacter;
            longitudActual:=longitudActual + 1;
            Get(ActualCharacter);
         end loop;
         p.lletres(longitudActual) := ActualCharacter;
         longitudActual:=longitudActual -1;
         p.llargaria:= longitudActual;
      end if;
   end get;











end pparaula;
