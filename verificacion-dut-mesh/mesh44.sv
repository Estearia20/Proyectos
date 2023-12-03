// Creates the mesh and the nearby elements, as well as the given trayectory depending on the mode
class mesh44;
  int mode;
  mesh router[6][6];
  bit [3:0] src;
  bit [7:0] source;
  bit [7:0] destiny;
  bit [7:0] path[$];
  bit [7:0] tmp[$];

  // Creates the elements of the mesh
  function new(int mode, bit [7:0] path[$]);
    this.mode = mode;
    this.path = path;
    // Generates the elements, with the corresponding id
    for (int i = 0; i <= 5; i++) begin
      automatic int k = i;
      for (int j = 0; j <= 5; j++) begin
        automatic int l = j;
        router[k][l] = new(k,l);
      end
    end
  endfunction

  function bit [7:0] convert(int src);
    case(src)
      0: source = 8'h01;
      1: source = 8'h02;
      2: source = 8'h03;
      3: source = 8'h04;
      4: source = 8'h10;
      5: source = 8'h20;
      6: source = 8'h30;
      7: source = 8'h40;
      8: source = 8'h51;
      9: source = 8'h52;
      10: source = 8'h53;
      11: source = 8'h54;
      12: source = 8'h15;
      13: source = 8'h25;
      14: source = 8'h35;
      15: source = 8'h45;
      default: source = 8'h00;
    endcase
    return source;
  endfunction
  
  task connect();
    #5;
    for (int i = 1; i <= 4; i++) begin
      automatic int k = i;
      for (int j = 1; j <= 4; j++) begin
        automatic int l = j;
        router[k][l].top   = router[k-1][l];
        router[k][l].down  = router[k+1][l];
        router[k][l].right = router[k][l+1];
        router[k][l].left  = router[k][l-1];
      	router[i][j].print();  
      end
    end
  endtask
      
  task run();
    source = convert(this.src);
    //$display("%h", source);
    #10;

    // Columns first
    if (!mode) begin
      // go throught columns first, it checks if col.src is higher of lower than col.dest
      // The following if-else statements push to the path queue, the elements of the trayectory depending on the source and destiny of the instruction, there are some specific cases that have to be taken into account for a proper generatrion of the path
      // if the movement has to be to the right ie, the destiny is at the right of the source
      if (source[3:0] < destiny[3:0]) begin
        if (destiny[3:0] == 5) begin
          if (source[7:4] == 0) begin
            // Adds source element
            path.push_back({source[7:4], source[3:0]});
            // Moves along the columns
            for (bit [3:0] i = source[3:0]; i < destiny[3:0]; i++) begin
              path.push_back({source[7:4]+4'h1, i});
            end
            // Moves along the rows
            for (bit [3:0] i = source[7:4]+4'h2; i <= destiny[7:4]; i++) begin
              path.push_back({i, destiny[3:0]-4'h1});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else if (source[7:4] == 5) begin
            // Adds source element
            path.push_back({source[7:4], source[3:0]});
            // Moves along the columns
            for (bit [3:0] i = source[3:0]; i < destiny[3:0]; i++) begin
              path.push_back({source[7:4]-4'h1, i});
            end
            // Moves along the rows
            for (bit [3:0] i = source[7:4]-4'h2; i >= destiny[7:4]; i--) begin
              path.push_back({i, destiny[3:0]-4'h1});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else begin
            if (destiny[7:4] > source[7:4]) begin
              // Moves along the columns
              for (bit [3:0] i = source[3:0]; i < destiny[3:0]; i++) begin
                path.push_back({source[7:4], i});
              end
              // Moves along the rows
              for (bit [3:0] i = source[7:4]+4'h1; i <= destiny[7:4]; i++) begin
                path.push_back({i, destiny[3:0]-4'h1});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
            else begin
              // Moves along the columns
              for (bit [3:0] i = source[3:0]; i < destiny[3:0]; i++) begin
                path.push_back({source[7:4], i});
              end
              // Moves along the rows
              for (bit [3:0] i = source[7:4]-4'h1; i >= destiny[7:4]; i--) begin
                path.push_back({i, destiny[3:0]-4'h1});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
          end
        end
        
        else begin
          if (source[7:4] == 0) begin
            // Adds source element
            path.push_back({source[7:4], source[3:0]});
            // Moves along the columns
            for (bit [3:0] i = source[3:0]; i <= destiny[3:0]; i++) begin
              path.push_back({source[7:4]+4'h1, i});
            end
            // Moves along the rows
            for (bit [3:0] i = source[7:4]+4'h2; i < destiny[7:4]; i++) begin
              path.push_back({i, destiny[3:0]});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else if (source[7:4] == 5) begin
            // Adds source element
            path.push_back({source[7:4], source[3:0]});
            // Moves along the columns
            for (bit [3:0] i = source[3:0]; i <= destiny[3:0]; i++) begin
              path.push_back({source[7:4]-4'h1, i});
            end
            // Moves along the rows
            for (bit [3:0] i = source[7:4]-4'h2; i > destiny[7:4]; i--) begin
              path.push_back({i, destiny[3:0]});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else begin
            if (destiny[7:4] > source[7:4]) begin
              // Moves along the columns
              for (bit [3:0] i = source[3:0]; i <= destiny[3:0]; i++) begin
                path.push_back({source[7:4], i});
              end
              // Moves along the rows
              for (bit [3:0] i = source[7:4]+4'h1; i <= destiny[7:4]; i++) begin
                path.push_back({i, destiny[3:0]});
              end
            end
            else begin
              // Moves along the columns
              for (bit [3:0] i = source[3:0]; i <= destiny[3:0]; i++) begin
                path.push_back({source[7:4], i});
              end
              // Moves along the rows
              for (bit [3:0] i = source[7:4]-4'h1; i > destiny[7:4]; i--) begin
                path.push_back({i, destiny[3:0]});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
          end         
        end
      end
      
      // if the movement has to be to the left ie, the destiny is at the left of the source
      else if (source[3:0] > destiny[3:0]) begin
        if (destiny[3:0] == 0) begin
          if (source[7:4] == 0) begin
            // Adds source element
            path.push_back({source[7:4], source[3:0]});
            // Moves along the columns
            for (bit [3:0] i = source[3:0]; i > destiny[3:0]; i--) begin
              path.push_back({source[7:4]+4'h1, i});
            end
            // Moves along the rows
            for (bit [3:0] i = source[7:4]+4'h2; i <= destiny[7:4]; i++) begin
              path.push_back({i, destiny[3:0]+4'h1});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else if (source[7:4] == 5) begin
            // Adds source element
            path.push_back({source[7:4], source[3:0]});
            // Moves along the columns
            for (bit [3:0] i = source[3:0]; i > destiny[3:0]; i--) begin
              path.push_back({source[7:4]-4'h1, i});
            end
            // Moves along the rows
            for (bit [3:0] i = source[7:4]-4'h2; i >= destiny[7:4]; i--) begin
              path.push_back({i, destiny[3:0]+4'h1});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else begin
            if (destiny[7:4] > source[7:4]) begin
              // Moves along the columns
              for (bit [3:0] i = source[3:0]; i > destiny[3:0]; i--) begin
                path.push_back({source[7:4], i});
              end
              // Moves along the rows
              for (bit [3:0] i = source[7:4]+4'h1; i <= destiny[7:4]; i++) begin
                path.push_back({i, destiny[3:0]+4'h1});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
            else begin
              // Moves along the columns
              for (bit [3:0] i = source[3:0]; i > destiny[3:0]; i--) begin
                path.push_back({source[7:4], i});
              end
              // Moves along the rows
              for (bit [3:0] i = source[7:4]-4'h1; i >= destiny[7:4]; i--) begin
                path.push_back({i, destiny[3:0]+4'h1});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
          end
        end
        
        else begin
          if (source[7:4] == 0) begin
            // Adds source element
            path.push_back({source[7:4], source[3:0]});
            // Moves along the columns
            for (bit [3:0] i = source[3:0]; i >= destiny[3:0]; i--) begin
              path.push_back({source[7:4]+4'h1, i});
            end
            // Moves along the rows
            for (bit [3:0] i = source[7:4]+4'h2; i < destiny[7:4]; i++) begin
              path.push_back({i, destiny[3:0]});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else if (source[7:4] == 5) begin
            // Adds source element
            path.push_back({source[7:4], source[3:0]});
            // Moves along the columns
            for (bit [3:0] i = source[3:0]; i >= destiny[3:0]; i--) begin
              path.push_back({source[7:4]-4'h1, i});
            end
            // Moves along the rows
            for (bit [3:0] i = source[7:4]-4'h2; i > destiny[7:4]; i--) begin
              path.push_back({i, destiny[3:0]});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else begin
            if (destiny[7:4] > source[7:4]) begin
              // Moves along the columns
              for (bit [3:0] i = source[3:0]; i >= destiny[3:0]; i--) begin
                path.push_back({source[7:4], i});
              end
              // Moves along the rows
              for (bit [3:0] i = source[7:4]+4'h1; i <= destiny[7:4]; i++) begin
                path.push_back({i, destiny[3:0]});
              end
            end
            else begin
              // Moves along the columns
              for (bit [3:0] i = source[3:0]; i >= destiny[3:0]; i--) begin
                path.push_back({source[7:4], i});
              end
              // Moves along the rows
              for (bit [3:0] i = source[7:4]-4'h1; i > destiny[7:4]; i--) begin
                path.push_back({i, destiny[3:0]});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
          end         
        end
      end     
      
      else begin
        if (source[3:0] == 0) begin
          // Moves along the columns
          for (bit [3:0] i = source[3:0]; i <= 1; i++) begin
            path.push_back({source[7:4], i});
          end
          if (source[7:4] < destiny[7:4]) begin
            // Moves along the rows
            for (bit [3:0] i = source[7:4]+4'h1; i <= destiny[7:4]; i++) begin
              path.push_back({i, source[3:0]+4'h1});
            end 
          end
          else begin
            // Moves along the rows
            for (bit [3:0] i = source[7:4]-4'h1; i >= destiny[7:4]; i--) begin
              path.push_back({i, source[3:0]+4'h1});
            end 
          end
          // Adds destiny element
          path.push_back({destiny[7:4], destiny[3:0]});
        end
        
        else if (source[3:0] == 5) begin
          // Moves along the columns
          for (bit [3:0] i = source[3:0]; i >= 4; i--) begin
            path.push_back({source[7:4], i});
          end
          if (source[7:4] < destiny[7:4]) begin
            // Moves along the rows
            for (bit [3:0] i = source[7:4]+4'h1; i <= destiny[7:4]; i++) begin
              path.push_back({i, source[3:0]-4'h1});
            end 
          end
          else begin
            // Moves along the rows
            for (bit [3:0] i = source[7:4]-4'h1; i >= destiny[7:4]; i--) begin
              path.push_back({i, source[3:0]-4'h1});
            end 
          end
          // Adds destiny element
          path.push_back({destiny[7:4], destiny[3:0]});
        end
        
        else if (source[7:4] == 0) begin
          // Moves along the columns
          for (bit [3:0] i = source[7:4]; i <= 1; i++) begin
            path.push_back({i, source[3:0]});
          end
          // Moves along the rows
          for (bit [3:0] i = source[7:4]+4'h2; i <= destiny[7:4]; i++) begin
            path.push_back({i, source[3:0]});
          end
        end
        else begin
          // Moves along the columns
          for (bit [3:0] i = source[7:4]; i >= 4; i--) begin
            path.push_back({i, source[3:0]});
          end
          // Moves along the rows
          for (bit [3:0] i = source[7:4]-4'h2; i > destiny[7:4]; i--) begin
            path.push_back({i, source[3:0]});
          end
          // Adds destiny element
          path.push_back({destiny[7:4], destiny[3:0]});
        end
      end
    end

    // Rows first
    else begin
      // go throught rows first, it checks if col.src is higher of lower than col.dest
      // The following if-else statements push to the path queue, the elements of the trayectory depending on the source and destiny of the instruction, there are some specific cases that have to be taken into account for a proper generatrion of the path
      // if the movement has to be to the right ie, the destiny is at the right of the source
      if (source[3:0] < destiny[3:0]) begin
        if (destiny[3:0] == 5) begin
          if (source[7:4] == 0) begin
            // Adds source element
            path.push_back({source[7:4], source[3:0]});
            // Moves along the rows
            for (bit [3:0] i = source[7:4]+4'h1; i <= destiny[7:4]; i++) begin
              path.push_back({i, source[3:0]});
            end
            // Moves along the columns
            for (bit [3:0] i = source[3:0]+4'h1; i < destiny[3:0]; i++) begin
              path.push_back({destiny[7:4], i});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else if (source[7:4] == 5) begin
            // Adds source element
            path.push_back({source[7:4], source[3:0]});
            // Moves along the rows
            for (bit [3:0] i = source[7:4]-4'h1; i >= destiny[7:4]; i--) begin
              path.push_back({i, source[3:0]});
            end
            // Moves along the columns
            for (bit [3:0] i = source[3:0]+4'h1; i < destiny[3:0]; i++) begin
              path.push_back({destiny[7:4], i});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else begin
            if (destiny[7:4] > source[7:4]) begin
              // Adds source element
              path.push_back({source[7:4], source[3:0]});
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i <= destiny[7:4]; i++) begin
                path.push_back({i, source[3:0]+4'h1});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]+4'h2; i < destiny[3:0]; i++) begin
                path.push_back({destiny[7:4], i});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
            else begin
              // Adds source element
              path.push_back({source[7:4], source[3:0]});
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i >= destiny[7:4]; i--) begin
                path.push_back({i, source[3:0]+4'h1});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]+4'h2; i < destiny[3:0]; i++) begin
                path.push_back({destiny[7:4], i});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
          end
        end
        
        else begin
          if (source[7:4] == 0) begin
            if (destiny[7:4] == 0) begin
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i <= 1; i++) begin
                path.push_back({i, source[3:0]});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]+4'h1; i <= destiny[3:0]; i++) begin
                path.push_back({destiny[7:4]+4'h1, i});
              end
            end
            else begin
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i < destiny[7:4]; i++) begin
                path.push_back({i, source[3:0]});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]+4'h1; i <= destiny[3:0]; i++) begin
                path.push_back({destiny[7:4]-4'h1, i});
              end
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else if (source[7:4] == 5) begin
            if (destiny[7:4] == 5) begin
                // Moves along the rows
                for (bit [3:0] i = source[7:4]; i >= 4; i--) begin
                  path.push_back({i, source[3:0]});
                end
                // Moves along the columns
              for (bit [3:0] i = source[3:0]+4'h1; i <= destiny[3:0]; i++) begin
                  path.push_back({destiny[7:4]-4'h1, i});
                end
            end
            else begin
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i > destiny[7:4]; i--) begin
                path.push_back({i, source[3:0]});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]+4'h1; i <= destiny[3:0]; i++) begin
                path.push_back({destiny[7:4]+4'h1, i});
              end
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else begin
            if (destiny[7:4] > source[7:4]) begin
              // Adds source element
              path.push_back({source[7:4], source[3:0]});
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i < destiny[7:4]; i++) begin
                path.push_back({i, source[3:0]+4'h1});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]+4'h2; i <= destiny[3:0]; i++) begin
                path.push_back({destiny[7:4]-4'h1, i});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
            else begin
              // Adds source element
              path.push_back({source[7:4], source[3:0]});
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i > destiny[7:4]; i--) begin
                path.push_back({i, source[3:0]+4'h1});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]+4'h2; i <= destiny[3:0]; i++) begin
                path.push_back({destiny[7:4]+4'h1, i});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
          end         
        end
      end
      
      // if the movement has to be to the left ie, the destiny is at the left of the source
      else if (source[3:0] > destiny[3:0]) begin
        if (destiny[3:0] == 0) begin
          if (source[7:4] == 0) begin
            // Moves along the rows
            for (bit [3:0] i = source[7:4]; i <= destiny[7:4]; i++) begin
              path.push_back({i, source[3:0]});
            end
            // Moves along the columns
            for (bit [3:0] i = source[3:0]-4'h1; i > destiny[3:0]; i--) begin
              path.push_back({destiny[7:4], i});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else if (source[7:4] == 5) begin
            // Moves along the rows
            for (bit [3:0] i = source[7:4]; i >= destiny[7:4]; i--) begin
              path.push_back({i, source[3:0]});
            end
            // Moves along the columns
            for (bit [3:0] i = source[3:0]-4'h1; i > destiny[3:0]; i--) begin
              path.push_back({destiny[7:4], i});
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else begin
            if (destiny[7:4] > source[7:4]) begin
              // Adds source element
              path.push_back({source[7:4], source[3:0]});
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i <= destiny[7:4]; i++) begin
                path.push_back({i, source[3:0]-4'h1});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]-4'h2; i > destiny[3:0]; i--) begin
                path.push_back({destiny[7:4], i});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
            else begin
              // Adds source element
              path.push_back({source[7:4], source[3:0]});
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i >= destiny[7:4]; i--) begin
                path.push_back({i, source[3:0]-4'h1});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]-4'h2; i > destiny[3:0]; i--) begin
                path.push_back({destiny[7:4], i});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
          end
        end
        
        else begin
          if (source[7:4] == 0) begin
            if (destiny[7:4] == 0) begin
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i <= 1; i++) begin
                path.push_back({i, source[3:0]});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]-4'h1; i >= destiny[3:0]; i--) begin
                path.push_back({destiny[7:4]+4'h1, i});
              end
            end 
            else begin
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i < destiny[7:4]; i++) begin
                path.push_back({i, source[3:0]});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]-4'h1; i >= destiny[3:0]; i--) begin
                path.push_back({destiny[7:4]-4'h1, i});
              end
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else if (source[7:4] == 5) begin
            if (destiny[7:4] == 5) begin
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i >= 4; i--) begin
                path.push_back({i, source[3:0]});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]-4'h1; i >= destiny[3:0]; i--) begin
                path.push_back({destiny[7:4]-4'h1, i});
              end
            end
            else begin
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i > destiny[7:4]; i--) begin
                path.push_back({i, source[3:0]});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]-4'h1; i >= destiny[3:0]; i--) begin
                path.push_back({destiny[7:4]+4'h1, i});
              end
            end
            // Adds destiny element
            path.push_back({destiny[7:4], destiny[3:0]});
          end
          
          else begin
            if (destiny[7:4] > source[7:4]) begin
              // Adds source element
              path.push_back({source[7:4], source[3:0]});
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i < destiny[7:4]; i++) begin
                path.push_back({i, source[3:0]-4'h1});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]-4'h2; i >= destiny[3:0]; i--) begin
                path.push_back({destiny[7:4]-4'h1, i});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
            else begin
              // Adds source element
              path.push_back({source[7:4], source[3:0]});
              // Moves along the rows
              for (bit [3:0] i = source[7:4]; i > destiny[7:4]; i--) begin
                path.push_back({i, source[3:0]-4'h1});
              end
              // Moves along the columns
              for (bit [3:0] i = source[3:0]-4'h2; i >= destiny[3:0]; i--) begin
                path.push_back({destiny[7:4]+4'h1, i});
              end
              // Adds destiny element
              path.push_back({destiny[7:4], destiny[3:0]});
            end
          end         
        end
      end     
      
      else begin
        if (source[3:0] == 0) begin
          // Moves along the columns
          for (bit [3:0] i = source[3:0]; i <= 1; i++) begin
            path.push_back({source[7:4], i});
          end
          if (source[7:4] < destiny[7:4]) begin
            // Moves along the rows
            for (bit [3:0] i = source[7:4]+4'h1; i <= destiny[7:4]; i++) begin
              path.push_back({i, source[3:0]+4'h1});
            end 
          end
          else begin
            // Moves along the rows
            for (bit [3:0] i = source[7:4]-4'h1; i >= destiny[7:4]; i--) begin
              path.push_back({i, source[3:0]+4'h1});
            end 
          end
          // Adds destiny element
          path.push_back({destiny[7:4], destiny[3:0]});
        end
        
        else if (source[3:0] == 5) begin
          // Moves along the columns
          for (bit [3:0] i = source[3:0]; i >= 4; i--) begin
            path.push_back({source[7:4], i});
          end
          if (source[7:4] < destiny[7:4]) begin
            // Moves along the rows
            for (bit [3:0] i = source[7:4]+4'h1; i <= destiny[7:4]; i++) begin
              path.push_back({i, source[3:0]-4'h1});
            end 
          end
          else begin
            // Moves along the rows
            for (bit [3:0] i = source[7:4]-4'h1; i >= destiny[7:4]; i--) begin
              path.push_back({i, source[3:0]-4'h1});
            end 
          end
          // Adds destiny element
          path.push_back({destiny[7:4], destiny[3:0]});
        end
        
        else if (source[7:4] == 0) begin
          // Moves along the columns
          for (bit [3:0] i = source[7:4]; i <= 1; i++) begin
            path.push_back({i, source[3:0]});
          end
          // Moves along the rows
          for (bit [3:0] i = source[7:4]+4'h2; i <= destiny[7:4]; i++) begin
            path.push_back({i, source[3:0]});
          end
        end
        else begin
          // Moves along the columns
          for (bit [3:0] i = source[7:4]; i >= 4; i--) begin
            path.push_back({i, source[3:0]});
          end
          // Moves along the rows
          for (bit [3:0] i = source[7:4]-4'h2; i > destiny[7:4]; i--) begin
            path.push_back({i, source[3:0]});
          end
          // Adds destiny element
          path.push_back({destiny[7:4], destiny[3:0]});
        end
      end
    end

    // Shows the path generated
    //$display("PATH: ");
    tmp = path;
    //while (tmp.size() > 0) begin
      //$display("%h", tmp.pop_front());
    //end
  endtask
endclass
