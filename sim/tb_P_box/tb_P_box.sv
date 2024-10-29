`timescale 1ns / 1ns

module tb_P_box;
	logic [47:0] data;
	logic [47:0] permutation;

initial begin
	$dumpfile("work/wave.ocd");
	$dumpvars(0, tb_P_box);
end

function logic [47:0] my_permutation(
		input [47:0] data,
	);
		return {
		data[45], data[42], data[25], data[22], data[4], data[2], 
		data[46], data[43], data[24], data[21], data[7], data[1],
		data[44], data[41], data[23], data[18], data[15], data[0],
		data[35], data[33], data[30], data[29], data[11], data[5],
		data[47], data[37], data[28], data[17], data[9], data[3],
		data[40], data[39], data[19], data[16], data[14], data[10],
		data[38], data[32], data[26], data[20], data[13], data[8],
		data[36], data[34], data[31], data[27], data[12], data[6]};
		
endfunction
	
initial begin
			parameter LENGTH = 1 << 48;
			logic[47:0] temp = 48'b1;
			//очевидные тесты
			for (; temp < LENGTH; temp = temp << 1) begin
				 data = temp; #1;
				 my_p = my_permutation(data)
				 if(permutation != my_p)
					$error("Permutation was failed: input -%b, tb_output -%b, output -%b", data, my_p, permutation);
				 data = ~temp; #1
				 if(permutation != my_p)
					$error("Permutation was failed: input -%b, tb_output -%b, output -%b", data, my_p, permutation);
			end
			//здесь будут рандомные тесты
			for(int j=0; j<100; j++) begin
				 data = $urandom_range(1, 1<<48); #1;
				 my_p = my_permutation(data)
				 if(permutation != my_p)
					$error("Permutation was failed: input -%b, tb_output -%b, output -%b", data, my_p, permutation);
			end
$finish;
end

P_box dut (
	.data(data),
	.permutation(permutation)
);

endmodule
