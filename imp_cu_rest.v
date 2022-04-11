//-----------------------------------------------------
// Universitatea Transilvania din Brasov
// Proiect  : Limbaje de descriere hardware
// Autor    : Olteanu Eduard
// Data     : 26.03.2022
//------------------------------------------------------
// Descriere   : Circuit de impartire secventiala
//-----

module imp_cu_rest#(
 parameter WIDTH           = 8
) (
 
input                       clk           , // semnal de ceas 						
input                       rst_n         ,
input					    req			  ,
input	[2* WIDTH -1:0]	    data_req	  ,	//A= deimpartitul, B = Impartitorul, P = intermediar

output reg 				  	ack		   	  ,
output reg	[2* WIDTH -1:0]	data_ack				// P = rest, A = CAT
  );
  
 wire A 
  //nevoie de un FMS
  
  // AB conectate impartind acelasi bus
  
  //daca AB primi 8 biti sunt A si ultimi 8 biti B