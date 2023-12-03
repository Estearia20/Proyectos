class fifo_emul #(parameter DEPTH = 32);
    typedef int item_t;  // Define the type of item stored in the FIFO.
    item_t queue[DEPTH]; // Array to hold the items.
    int head;            // Index of the head of the FIFO.
    int tail;            // Index of the tail of the FIFO.

    // Method to add an item to the FIFO.
    function void push(item_t item);
        if ((tail + 1) % DEPTH != head) begin
            queue[tail] = item;
            tail = (tail + 1) % DEPTH;
    end else begin
        $display("Error: FIFO is full.");
        end
    endfunction

    // Method to remove an item from the FIFO.
    function item_t pop();
        item_t item;
        if (head != tail) begin
            item = queue[head];
            head = (head + 1) % DEPTH;
        end else begin
        $display("Error: FIFO is empty.");
        end
        return item;
    endfunction

    // Method to check if the FIFO is empty.
    function bit is_empty();
        return (head == tail);
    endfunction

    // Method to check if the FIFO is full.
    function bit is_full();
        return ((tail + 1) % DEPTH == head);
    endfunction

    // Method to get the current depth of the FIFO.
    function int get_depth();
        return ((tail - head + DEPTH) % DEPTH);
    endfunction

    function int tot_depth();
        return DEPTH;
    endfunction
endclass

