class mesh;
  int id_r;
  int id_c;
  mesh top;
  mesh down;
  mesh right;
  mesh left;

  function new(int id_r, int id_c);
    this.id_r = id_r;
    this.id_c = id_c;
  endfunction

  function void print;
    //$display("ID_R = %2d, ID_C = %2d, TOP_R = %2d, TOP_C = %2d, BOT_R = %2d, BOT_C = %2d, RIGHT_R = %2d, RIGHT_C = %2d, LEFT_R = %2d, LEFT_C = %2d", this.id_r, this.id_c, this.top.id_r, this.top.id_c, this.down.id_r, this.down.id_c, this.right.id_r, this.right.id_c, this.left.id_r, this.left.id_c);
    //$display("ID_R = %2d, ID_C = %2d", this.id_r, this.id_c);
    //$display(this.top);
    //$display(this.down);
    //$display(this.right);
    //$display(this.left);
  endfunction
endclass
