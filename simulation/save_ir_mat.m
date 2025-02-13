function save_ir_mat(filepath, rir_rev, rir_dry, room_rev, room_dry, sources, receivers)
    % SAVE_IR_MAT - save data to mat file.
    %
    % Input:
    %   hrtf_source         	hrtf dataset source
    %   type                    train or val
    %   
    % Output:
    %   formfactor              string of the formfactor
    %

    %% Match the RAZR format
    ir_sim = rir_rev;
    ir_sim_dry = rir_dry;

    room_temperature = room_rev.Temp;
    room_humidity = room_rev.Humidity;
    room_dimension = room_rev.Dim;
    room_freq = room_rev.Freq;

    room_scattering = room_rev.Scattering;
    room_abscoeff = room_rev.Absorption;
    dry_room_abscoeff = room_dry.Absorption;

    rt60 = EyringKuttruffReverberationTime(room_rev, false)';

    position = receivers.Location;
    % yaw, pitch (roll = 0)
    orientation = receivers.Orientation(1:2);

    src_positions = zeros(numel(sources), 3);
    for i = 1:numel(sources)
        src_positions(i, :) = sources(i).Location;
    end

    %% Prepare the folder
    [folder, ~] = fileparts(filepath);
    mkdir(folder);

    %% save file
    save(filepath, 'ir_sim', 'ir_sim_dry', 'position', 'orientation', ...
        'src_positions', 'rt60', 'room_dimension', 'room_freq', ...
        'room_abscoeff', 'room_scattering', 'dry_room_abscoeff', 'room_humidity', 'room_temperature');
end