#region DETERMINE GRID X/Y

//grid_x = floor(mouse_x / GRID_SIZE);
//grid_y = floor(mouse_y / GRID_SIZE);

grid_x = floor((mouse_x / iso_width) + (mouse_y / iso_height));
grid_y = floor((mouse_y / iso_height) - (mouse_x / iso_width));

// deixa grid entre 0 e 9
grid_x = clamp(grid_x, 0, hcells - 1); 
grid_y = clamp(grid_y, 0, vcells - 1);

#endregion

#region MUDAR new_index / MUDAR parte  (decide entre e editando chão ou editando decoração)

if(keyboard_check_pressed(vk_right)){
	if(keyboard_check(vk_shift) == false){
		if((new_index + 1) < sprite_get_number(current_sprite)) new_index++;
		else new_index = 0;
	}
	else{
		#region muda parte do tile entre mudar chão e decoração
		
		if((current_part + 1) <= e_tile_data.decoration_index) current_part++;
		else current_part = 0;
		
		current_sprite = global.cell_sprites[current_part]; // muda current_sprite
		new_index = 1; // reseta image index
		
		#endregion
	}
}

if(keyboard_check_pressed(vk_left)){
	if(keyboard_check(vk_shift) == false){
		if(new_index > 0) new_index--;
		else new_index = (sprite_get_number(current_sprite) - 1);
	}
	else{
		#region muda parte do tile entre mudar chão e decoração
		
		if(current_part - 1 >= 0) current_part--;
		else current_part = e_tile_data.decoration_index;
		
		current_sprite = global.cell_sprites[current_part]; // muda current_sprite
		new_index = 1; // reseta image index
		
		#endregion
	}
}

#endregion

#region PINTA O MAPA

if(mouse_check_button(mb_left)){
	if(mouse_check_button(mb_left)){
		var list = ds_terrain_data[# grid_x, grid_y];
		
		list[| current_part] = new_index;
		list[| e_tile_data.height] = current_height;
	}
}

#endregion

#region MOVE A CAMERA

if(keyboard_check(ord("W"))) cy -= 10;
if(keyboard_check(ord("S"))) cy += 10;
if(keyboard_check(ord("A"))) cx -= 10;
if(keyboard_check(ord("D"))) cx += 10;

if(keyboard_check(ord("W")) || keyboard_check(ord("S")) || keyboard_check(ord("A")) || keyboard_check(ord("D"))){
	camera_set_view_pos(view_camera[0], cx, cy);
}

#endregion

#region MUDA ALTURA

if(keyboard_check_pressed(vk_up)){
	if((current_height + 1) < max_height) current_height++;
	else current_height = 0;
}

if(keyboard_check_pressed(vk_down)){
	if(current_height > 0) current_height--;
	else current_height = (max_height - 1);
}

#endregion

#region MUDA DISPLAY_ALL_HEIGHTS

if(keyboard_check_pressed(vk_tab)) display_all_heights = !display_all_heights;

#endregion


