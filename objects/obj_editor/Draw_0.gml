for(var yy = 0; yy < vcells; yy++){
	for(var xx = 0; xx < hcells; xx++){
		
		#region DRAW CELL
		
		// obtem dados necessário para calculos
		
		var list = ds_terrain_data[# xx, yy];
		floor_idx = list[| e_tile_data.floor_idex];
		height = list[| e_tile_data.height];
		
		draw_x = (xx - yy) * (iso_width / 2);
		
		// desenha tile para cada altura
		for(var draw_height = 0; draw_height <= height; draw_height++){
			
			// rendeniza somente tiles da altura atual selecionada se display_all_heights for false
			if((display_all_heights == false && draw_height <= current_height) || (display_all_heights == true)){
				draw_y = (xx + yy) * (iso_height / 2) - (draw_height * (iso_height / 2));
			
				// cria uma tonalidade para que cada altura tenha uma coloração difetente
				var rgb_value = 150 + (draw_height * 9);
				var col = make_colour_rgb(rgb_value, rgb_value, rgb_value);
			
				// escala x, escala y, rotação, tranparencia, alpha
				draw_sprite_ext(spr_iso_floor, floor_idx, draw_x, draw_y, 1, 1, 0, col, 1);
			
				if(draw_height == height){
					var spr = global.cell_sprites[e_tile_data.decoration_index];
					var index = list[| e_tile_data.decoration_index];
					draw_sprite_ext(spr, index, draw_x, draw_y, 1, 1, 0, col, 1);
				}
			}		
		}
		
		#endregion
		
		#region TESTING
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_colour(c_gray);
		
		var list = ds_terrain_data[# xx, yy];
		//draw_text(draw_x, draw_y, string(list));
		
		#endregion
		
		#region DRAW CURSOR
		
		if(xx == grid_x && yy == grid_y){
			for(var draw_height = 0; draw_height <= current_height; draw_height++){
				draw_y = (xx + yy) * (iso_height / 2) - (draw_height * (iso_height / 2));
				draw_sprite(spr_iso_cursor, 0, draw_x, draw_y);
			}
			
			#region mostra blueprint da decoração
			
			if(current_part == e_tile_data.decoration_index){
				var spr = global.cell_sprites[current_part];
				draw_sprite_ext(spr, new_index, draw_x, draw_y, 1, 1, 0, c_yellow, 1);
			}
			
			#endregion
		}
		
		#endregion
	}
}