#region PREPARA ENUM DA LISTA usado para armazenar info sobre os tiles (eixo z)

enum e_tile_data{
	floor_idex,
	decoration_index,
	height,
	last,
}

#endregion

#region SETUP A GRID

hcells = 10;
vcells = 10;

#macro GRID_SIZE 16

ds_terrain_data = ds_grid_create(hcells, vcells);

for(var yy = 0; yy < vcells; yy++){
	for(var xx = 0; xx < hcells; xx++){
		var list = ds_list_create();
		
		for(var i = 0; i < e_tile_data.last; i++){
			if(i == e_tile_data.floor_idex) list[| i] = 1;
			else list[| i] = 0;
		}
		
		ds_terrain_data[# xx, yy] = list;
		
		show_debug_message(list);
	}
}

#endregion

#region PREPATA ARRAY DE SPRITE

// cria array de sprites de decoração para uso global

global.cell_sprites[e_tile_data.floor_idex] = spr_iso_floor;
global.cell_sprites[e_tile_data.decoration_index] = spr_iso_decoration;

#endregion

#region EXTRA VARIABLES

grid_x = 0; // pos. mouse no grid
grid_y = 0; // pos. mouse no grid
new_index = 1; // mudar index do grid, assim mudando o sprinte

iso_width = sprite_get_width(spr_iso_width_heigth);
iso_height = sprite_get_height(spr_iso_width_heigth);

// centraliza camera no mapa
cx = (iso_width / 2) - (camera_get_view_width(view_camera[0]) / 2);
cy = -(camera_get_view_height(view_camera[0]) / 4);
camera_set_view_pos(view_camera[0], cx, cy);

// implementação camadas

current_height = 0; // altera altura do tile para curr_h
max_height = 12; // altura maxima tile


// implementação decoração

current_part = e_tile_data.floor_idex;
current_sprite = global.cell_sprites[current_part];


display_all_heights = true; // limita altura que tiles podem ser mostrados (util para editar fundo do mapa)

#endregion