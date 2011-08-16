--[[----------------------------------------------------------------------------
-- Duplex.NOW_Controller
----------------------------------------------------------------------------]]--

-- Custom 'device' for controlling the Notes On Wheels application

--------------------------------------------------------------------------------

-- Standard Notes On Wheels configuration

duplex_configurations:insert {

  -- configuration properties
  name = "Notes On Wheels",
  pinned = true,

  -- device properties
  device = {
    class_name = nil,          
    display_name = "Custombuilt",
    device_port_in = "",
    device_port_out = "",
    control_map = "Controllers/Custombuilt/NOW_Controller.xml",
    thumbnail = "NOW_Controller.bmp",
    protocol = DEVICE_MIDI_PROTOCOL
  },
  
  applications = {
    NotesOnWheels = {
      mappings = {
        --[[
        multi_sliders = {
          group_name = "DialRow_1",
        },
        multi_adjust = {
          group_name = "Fader_1",
        },
        ]]
        pitch_sliders = {
          group_name = "DialRow_2",
        },
        pitch_adjust = {
          group_name = "Fader_2",
        },
        velocity_sliders = {
          group_name = "DialRow_3",
        },
        velocity_adjust = {
          group_name = "Fader_3",
        },
        offset_sliders = {
          group_name = "DialRow_4",
        },
        offset_adjust = {
          group_name = "Fader_4",
        },
        gate_sliders = {
          group_name = "DialRow_5",
        },
        gate_adjust = {
          group_name = "Fader_5",
        },
        retrig_sliders = {
          group_name = "DialRow_6",
        },
        retrig_adjust = {
          group_name = "Fader_6",
        },
        num_steps = {
          group_name = "ButtonRow",
          --orientation = HORIZONTAL,
        },
        step_spacing = {
          group_name = "Dials",
          index = 1,
        },
        --num_lines = {
        --  group_name = "Dials",
        --  index = 2,
        --},
        write = {
          group_name = "Controls",
          index = 1,
        },
        learn = {
          group_name = "Controls",
          index = 2,
        },
        fill = {
          group_name = "Controls",
          index = 3,
        },
        global = {
          group_name = "Controls",
          index = 4,
        },
        set_mode_pitch = {
          group_name = "Controls",
          index = 5,
        },
        set_mode_velocity = {
          group_name = "Controls",
          index = 6,
        },
        set_mode_offset = {
          group_name = "Controls",
          index = 7,
        },
        set_mode_gate = {
          group_name = "Controls",
          index = 8,
        },
        set_mode_retrig = {
          group_name = "Controls",
          index = 9,
        },
        shift_up = {
          group_name = "ButtonPair",
          index = 1,
        },
        shift_down = {
          group_name = "ButtonPair",
          index = 2,
        },
        position = {
          group_name = "LedRow",
        },

      }
    }
  }
}


--------------------------------------------------------------------------------

-- Compact Notes On Wheels configuration

duplex_configurations:insert {

  -- configuration properties
  name = "Notes On Wheels (compact)",
  pinned = true,

  -- device properties
  device = {
    class_name = nil,          
    display_name = "Custombuilt",
    device_port_in = "",
    device_port_out = "",
    control_map = "Controllers/Custombuilt/NOW_Controller_compact.xml",
    thumbnail = "NOW_Controller.bmp",
    protocol = DEVICE_MIDI_PROTOCOL
  },
  
  applications = {
    NotesOnWheels = {
      mappings = {
        multi_sliders = {
          group_name = "DialRow_1",
        },
        multi_adjust = {
          group_name = "Fader_1",
        },
        --[[
        pitch_sliders = {
          group_name = "DialRow_2",
        },
        pitch_adjust = {
          group_name = "Fader_2",
        },
        velocity_sliders = {
          group_name = "DialRow_3",
        },
        velocity_adjust = {
          group_name = "Fader_3",
        },
        offset_sliders = {
          group_name = "DialRow_4",
        },
        offset_adjust = {
          group_name = "Fader_4",
        },
        gate_sliders = {
          group_name = "DialRow_5",
        },
        gate_adjust = {
          group_name = "Fader_5",
        },
        retrig_sliders = {
          group_name = "DialRow_6",
        },
        retrig_adjust = {
          group_name = "Fader_6",
        },
        ]]
        num_steps = {
          group_name = "ButtonRow",
          --orientation = HORIZONTAL,
        },
        step_spacing = {
          group_name = "Dials",
          index = 1,
        },
        --num_lines = {
        --  group_name = "Dials",
        --  index = 2,
        --},
        write = {
          group_name = "Controls",
          index = 1,
        },
        learn = {
          group_name = "Controls",
          index = 2,
        },
        --[[
        fill = {
          group_name = "Controls",
          index = 3,
        },
        ]]
        global = {
          group_name = "Controls",
          index = 3,
        },
        set_mode_pitch = {
          group_name = "Controls",
          index = 4,
        },
        set_mode_velocity = {
          group_name = "Controls",
          index = 5,
        },
        set_mode_offset = {
          group_name = "Controls",
          index = 6,
        },
        set_mode_gate = {
          group_name = "Controls",
          index = 7,
        },
        set_mode_retrig = {
          group_name = "Controls",
          index = 8,
        },
        shift_up = {
          group_name = "ButtonPair",
          index = 1,
        },
        shift_down = {
          group_name = "ButtonPair",
          index = 2,
        },
        position = {
          group_name = "LedRow",
        },

      }
    }
  }
}
