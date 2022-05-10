//-----------------------------------------------------
// Universitatea Transilvania din Brasov
// Proiect  : Limbaje de descriere hardware
// Autor    : Olteanu Eduard
// Data     : 26.03.2022
//------------------------------------------------------
// Descriere   : Circuit de impartire secventiala
//-----

module imp_cu_rest#(
 parameter WIDTH           = 'd4
) (
 
input                       clk           ,                // semnal de ceas 						
input                       rst_n         ,
input                       [WIDTH-1 : 0]   A ,          //A= deimpartitul, // P = intermediar
input                       [WIDTH-1 : 0]   B ,         //B=impartitorul	
input                       start         ,   	        // req
output reg                  [WIDTH-1 : 0]   Q ,        // Q = A = rezultatul
output reg                  [WIDTH-1 : 0]   R ,       // R = P = Restul impartirii
output reg                  done          ,           // ack        
 );

  logic [WIDTH-1 : 0]       B1;                        // copie B
  logic [WIDTH-1 : 0]       Q1, Q1_next;              // intermediar
  logic [WIDTH-1 : 0]       ac, ac_next;             // acumulator
  logic [WIDTH-1 : 0]       i;                      // numarul de iteratii

  parameter busy = 1'b0;
  parameter valid = 1'b1;
  parameter dbz = 1'b0;      // divizatorul este zero 

always_comb begin
  if (ac >={1'b0,B1}) begin
    ac_next = ac - B1;
    {ac_next,Q1_next} = {ac_next[WIDTH-1:0],Q1,1'b1};
  end else begin
    {ac_next, Q1_next} = {ac,Q1} << 1;
  end
end

always_ff @(posedge clk) begin
  if (start) begin
    valid <= 1'b0;
    i <= 0;
    if (y = 1'b0) begin // verfica daca divizorul este zero
      busy <= 1'b0;
      dbz <= 1'b1;
    end else begin      // incarc valorile
      busy <= 1'b1;
      dbz <= 1'b0;
      y1 <= y;
      {ac,q1} = {{WIDTH-1:0}, x, 1'b0};
    end
  end else if (busy) begin
    if (i == WIDTH-1) begin  // verifica daca s-a terminat iteratia
      busy <= 1'b0;
      valid <= 1'b1;
      Q <= Q1_next;
      R <= ac_next[WIDTH-1];  // undo ultima shiftare
    end else begin        // iteratie 
      i <= i + 1;
      ac <= ac_next;
      Q <= Q1_next;
    end
  end
end
endmodule
