//Weyfikacja Systemów Cyfrowych - Projekt 
//£ukasz Sztuka 243168


`timescale 1 ns/10 ps

module alu8bit_tb;

        //Wejœcia
        reg nreset;
        reg clk;
        reg [7:0] u_a;
        reg [7:0] u_b;
        reg [3:0] op;
        
        //Wyjœcia
        wire borrow;
        wire [15:0] u_result;
        
        //Po³¹czenie z testowan¹ jednostk¹ 
        alu8bit_unsigned uut(
                .nreset(nreset),
                .clk(clk),
                .u_a(u_a),
                .u_b(u_b),
                .op(op),
                .borrow(borrow),
                .u_result(u_result)
                );
                
    //Blok Zegara
    always
    begin
        clk = 0;
        #5;
        clk = 1;
        #5;
    end
    
    //Blok Zegara2 
integer clk2;
    always
    begin
        clk2 = 0;
        #2.5;
        clk2 = 1;
        #2.5;
    end

integer plik_wy;
integer plik_we;
integer pop;        // Zmienne pomocnicze
integer a2;
integer b2;
integer op2;
integer a3;
integer b3;
integer op3;
integer a4;
integer res3;
integer test;

    initial begin
        
        nreset = 1;
        plik_wy = $fopen("C:/Users/DESKTOP-12/Desktop/WSC/alu8bit/Raport.txt","w"); // Otworzenie plików
        plik_we = $fopen("C:/Users/DESKTOP-12/Desktop/WSC/alu8bit/data_in.txt","r");
        
        if (plik_we==0)     // Test poprawnoœci otworzenia plików
        begin
            $display("B³¹d pliku wejœciowego!");
            $finish;
        end
        if (plik_wy==0)
        begin
            $display("B³¹d pliku wyjœciowego!");
            $finish;
        end
        
        #480        //Czas trawania symulacji (10 = jednen cykl zegara)
        
        if(plik_we!=0)      //Zamkniêcie plików
        begin
            $fclose(plik_we);
        end
        if(plik_wy!=0)
        begin
            $fclose(plik_wy);
            $finish;
        end 
    end 
    
    
    always @(negedge clk) //wczytywanie linijki z pliku co zbocze opadaj¹ce zegara
    begin
        $fscanf(plik_we,"%b %b %b %b\n", u_a, u_b, op, nreset);
        a3 = a2;        // Przepisanie wartoœci w celu synchronizacji 
        b3 = b2;
        op3 = op2;
    end
    
    always @(posedge clk) //co zbocze rosn¹ce zegara
    begin
        a2 = u_a;
        b2 = u_b;
        op2 = op;
    end
    
    always @(posedge clk2 && clk == 0) //co zbocze rosn¹ce zegara2 i 0 na lini zegara
    begin
        res3 = u_result;
    end
    
    
    always @( posedge clk)
    begin    
        if(op3 == 0)    //Rozpoznanie wykonywanej operacji
        begin
            $fdisplay(plik_wy, "Test and");
            test = a3 & b3;
            if (res3 == test)   // Porównanie wartoœci obliczonej przez uk³ad testowany i ukad testuj¹cy
            begin
            pop =1;
            end
            else begin
            pop =0;
            end
            
            $fdisplay(plik_wy, "We: %b, %b; Wy: %b; Poprawnoœæ: %b", a3, b3, res3, pop);
        end
        

        if(op3 == 1)    // Analogicznie jak w poprzednim przypadku
        begin
            $fdisplay(plik_wy, "Test or");
            test = a3 | b3 ;
            if (res3 == test)
            begin
            pop =1;
            end
            else begin
            pop =0;
            end
            
            $fdisplay(plik_wy, "We: %b, %b; Wy: %b; Poprawnoœæ: %b", a3, b3, res3, pop);
        end
        
        if(op3 == 2)
        begin
            $fdisplay(plik_wy, "Test Xor");
            test = a3 ^ b3;
            if (res3 == test)
            begin
            pop =1;
            end
            else begin
            pop =0;
            end
            
            $fdisplay(plik_wy, "We: %b, %b; Wy: %b; Poprawnoœæ: %b", a3, b3, res3, pop);
        end
        
        if(op3 == 3)
        begin
            $fdisplay(plik_wy, "Test Not");
            a4 = a3 ^ 'b11111111;
            test = a4 + 65280;
            if (res3 == test)
            begin
            pop =1;
            end
            else begin
            pop =0;
            end
            
            $fdisplay(plik_wy, "We: %b; Wy: %b; Poprawnoœæ: %b", a3, res3, pop);
        end
        
        if(op3 == 4)  
        begin
            $fdisplay(plik_wy, "Test porównania a=b");
            if (a3 == b3)
            begin
            test =65535;
            end
            else begin
            test =0;
            end
            if (res3 == test)
            begin
            pop =1;
            end
            else begin
            pop =0;
            end            
            
            $fdisplay(plik_wy, "We: %b, %b; Wy: %b; Poprawnoœæ: %b", a3, b3, res3, pop);
        end
        
        if(op3 == 5)  
        begin
            $fdisplay(plik_wy, "Test porównania a>b");
            if (a3 > b3)
            begin
            test =65535;
            end
            else begin
            test =0;
            end
            if (res3 == test)
            begin
            pop =1;
            end
            else begin
            pop =0;
            end            
            
            $fdisplay(plik_wy, "We: %b, %b; Wy: %b; Poprawnoœæ: %b", a3, b3, res3, pop);
        end
        
        if(op3 == 6)  
        begin
            $fdisplay(plik_wy, "Test porównania a<b");
            if (a3 < b3)
            begin
            test =65535;
            end
            else begin
            test =0;
            end
            if (res3 == test)
            begin
            pop =1;
            end
            else begin
            pop =0;
            end            
            
            $fdisplay(plik_wy, "We: %b, %b; Wy: %b; Poprawnoœæ: %b", a3, b3, res3, pop);
        end
        
        if(op3 == 8)
        begin
            $fdisplay(plik_wy, "Test dodawanie");
            test = a3 + b3;
            if (res3 == test)
            begin
            pop =1;
            end
            else begin
            pop =0;
            end
            
            $fdisplay(plik_wy, "We: %b, %b; Wy: %b; Poprawnoœæ: %b", a3, b3, res3, pop);
        end
        
        if(op3 == 9)
        begin
            $fdisplay(plik_wy, "Test odejmowanie");
            if (a3 >= b3)
            begin
                test = (a3 - b3);
            end
            else begin
                test = ((a3 +256)- b3);
            end
            if (res3 == test)
            begin
            pop =1;
            end
            else begin
            pop =0;
            end
            
            $fdisplay(plik_wy, "We: %b, %b; Wy: %b; Poprawnoœæ: %b", a3, b3, res3, pop);
        end
        
        if(op3 == 10)  
        begin
            $fdisplay(plik_wy, "Test dzielenie");
            if (a3 >= b3)
            begin
                test = a3 / b3;
            end
            if (b3 == 0)
            begin
                test = 255;
            end
            else begin
                test = 0;
            end
            
            if (res3 == test)
            begin
            pop =1;
            end
            else begin
            pop =0;
            end
            
            $fdisplay(plik_wy, "We: %b, %b; Wy: %b; Poprawnoœæ: %b", a3, b3, res3, pop);
        end

        if(op3 == 11)
        begin
            $fdisplay(plik_wy, "Test monzenie");
            test = a3 * b3;
            if (res3 == test)
            begin
            pop =1;
            end
            else begin
            pop =0;
            end
            
            $fdisplay(plik_wy, "We: %b, %b; Wy: %b; Poprawnoœæ: %b", a3, b3, res3, pop);
        end
        
        if(op == 7)
        begin
            $fdisplay(plik_wy, "Operator niepoprawny");    
        end
        if(op == 12)
        begin
            $fdisplay(plik_wy, "Operator niepoprawny");    
        end 
        if(op == 13)
        begin
            $fdisplay(plik_wy, "Operator niepoprawny");    
        end
        if(op == 14)
        begin
            $fdisplay(plik_wy, "Operator niepoprawny");    
        end
        if(op == 15)
        begin
            $fdisplay(plik_wy, "Operator niepoprawny");    
        end
        if(op == 16)
        begin
            $fdisplay(plik_wy, "Operator niepoprawny");    
        end
        
        if(nreset == 0)
        begin
            $fdisplay(plik_wy, "RESET W£¥CZONY");    
        end
    end
    
endmodule