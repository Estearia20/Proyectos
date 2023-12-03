`include "mesh.sv"
`include "mesh44.sv"

module tb;
    mesh44 mesh;

    initial begin
        mesh = new(0);
     	mesh.run();
    end
endmodule
