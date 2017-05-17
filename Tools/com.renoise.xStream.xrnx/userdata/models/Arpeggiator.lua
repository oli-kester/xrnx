--[[===========================================================================
Arpeggiator.lua
===========================================================================]]--

return {
arguments = {
  {
      ["locked"] = false,
      ["name"] = "mode",
      ["linked"] = false,
      ["value"] = 2,
      ["properties"] = {
          ["min"] = 1,
          ["impacts_buffer"] = false,
          ["max"] = 5,
          ["items"] = {
              "up",
              "down",
              "up_down",
              "ordered",
              "random",
          },
          ["display_as"] = "popup",
          ["fire_on_start"] = false,
      },
      ["description"] = "",
  },
  {
      ["locked"] = false,
      ["name"] = "lock_to",
      ["linked"] = false,
      ["value"] = 1,
      ["properties"] = {
          ["items"] = {
              "pattern",
              "keystroke",
              "stream",
          },
          ["fire_on_start"] = false,
          ["max"] = 3,
          ["impacts_buffer"] = false,
          ["display_as"] = "popup",
          ["min"] = 1,
      },
      ["description"] = "",
  },
  {
      ["locked"] = false,
      ["name"] = "stepsize",
      ["linked"] = false,
      ["value"] = 2,
      ["properties"] = {
          ["zero_based"] = false,
          ["fire_on_start"] = false,
          ["max"] = 16,
          ["display_as"] = "integer",
          ["min"] = 1,
      },
      ["description"] = "",
  },
  {
      ["locked"] = false,
      ["name"] = "oct_range",
      ["linked"] = false,
      ["value"] = 2,
      ["properties"] = {
          ["min"] = 0,
          ["impacts_buffer"] = false,
          ["max"] = 4,
          ["zero_based"] = false,
          ["display_as"] = "integer",
          ["fire_on_start"] = false,
      },
      ["description"] = "",
  },
},
presets = {
  {
      ["stepsize"] = 1,
      ["name"] = "",
      ["mode"] = 1,
      ["oct_range"] = 1,
      ["lock_to"] = 1,
  },
},
data = {
  ["get_voice_index"] = [[-------------------------------------------------------------------------------
-- return the active voice index and maintain the position/octave
-------------------------------------------------------------------------------

return function(arg)
  local voice,voice_idx = nil  
  if (args.mode == 1) then -- up --
  
    voice = xvoices[data.position]
    voice,voice_idx = xvoicemgr:get_by_pitch(voice.values[1])
    local _,higher_idx = xvoicemgr:get_higher(voice_idx)
    local _,highest_idx = xvoicemgr:get_highest()
    if higher_idx then
      voice_idx = higher_idx
    elseif (voice_idx == highest_idx) then
      local lowest_voice,lowest_idx = xvoicemgr:get_lowest()
      voice_idx = lowest_idx    
      data.rotate_oct("up")
    else
      voice_idx = highest_idx
    end
    
  elseif (args.mode == 2) then -- down --
    
    voice = xvoices[data.position]
    voice,voice_idx = xvoicemgr:get_by_pitch(voice.values[1])

    local _,lower_idx = xvoicemgr:get_lower(voice_idx)
    local _,lowest_idx = xvoicemgr:get_lowest()
    if lower_idx then
      voice_idx = lower_idx
    elseif (voice_idx == lowest_idx) then
      local _,highest_idx = xvoicemgr:get_highest()
      voice_idx = highest_idx        
      data.rotate_oct("down")     
    else
      voice_idx = lowest_idx
    end
        
  elseif (args.mode == 3) then -- up_down --

    voice = xvoices[data.position]
    voice,voice_idx = xvoicemgr:get_by_pitch(voice.values[1])
  
    local _,lowest_idx = xvoicemgr:get_lowest()
    local _,highest_idx = xvoicemgr:get_highest()
    
    if (highest_idx == voice_idx) then
      local _,lower_idx = xvoicemgr:get_lower(voice_idx)
      voice_idx = lower_idx
      data.direction = "down"
      data.rotate_oct("down")
    elseif (lowest_idx == voice_idx) then
      local _,higher_idx = xvoicemgr:get_higher(voice_idx)
      voice_idx = higher_idx
      data.direction = "up"
      data.rotate_oct("up")
    elseif (data.direction == "up") then
      local _,higher_idx = xvoicemgr:get_higher(voice_idx)
      voice_idx = higher_idx
    elseif (data.direction == "down") then
      local _,lower_idx = xvoicemgr:get_lower(voice_idx)
      voice_idx = lower_idx
    end
    
  elseif (args.mode == 4) then -- ordered --
  
    data.position = (data.position+1) % #xvoices
    if (data.position == 0) then
      data.position = #xvoices
      data.rotate_oct("up")
    end    
    
  elseif (args.mode == 5) then -- random --
  
    data.position = math.random(1,#xvoices)
    data.curr_oct = math.random(0,args.oct_range)
    
  end
  --print(">>> voice_idx",voice_idx)
  if not voice_idx then
    voice_idx = data.position
  else
    data.position = voice_idx  
  end
  return voice_idx
end]],
  ["direction"] = [[-- "up" or "down" (when up_down)
return "up"]],
  ["curr_oct"] = [[-- return a value of some kind 
return 0]],
  ["position"] = [[-- return a value of some kind 
return 1]],
  ["rotate_oct"] = [[-- return a value of some kind
return function(direction)
  if (direction == "down") then
    if (data.curr_oct > 0) then
      data.curr_oct = data.curr_oct-1
    elseif (data.curr_oct == 0) then
      data.curr_oct = args.oct_range
    end  
  elseif (direction == "up") then
    if (data.curr_oct < args.oct_range) then
      data.curr_oct = data.curr_oct+1
    elseif (data.curr_oct == args.oct_range) then
      data.curr_oct = 0
    end    
  end
  return 
end]],
  ["keystroke_xinc"] = [[-- remember the position at which the key was first struck
return nil]],
},
events = {
  ["voice.triggered"] = [[------------------------------------------------------------------------------
-- respond to voice-manager events
-- ('xvoicemgr.triggered/released/stolen_index' contains the value)
------------------------------------------------------------------------------

-- initialize on first note
if (#xvoices == 1) then
  data.position = 1
  data.keystroke_xinc = xinc  
  data.curr_oct = args.oct_range
  
end

xbuffer:wipe_futures()]],
  ["voice.released"] = [[------------------------------------------------------------------------------
-- respond to voice-manager events
-- ('xvoicemgr.triggered/released/stolen_index' contains the value)
------------------------------------------------------------------------------

-- make sure position is always valid
if (data.position == #xvoices) then
  data.position = data.position-1
end]],
  ["args.oct_range"] = [[------------------------------------------------------------------------------
-- respond to argument 'oct_range' changes
-- @param val (number/boolean/string)}
------------------------------------------------------------------------------

-- ensure octave is always valid
if (data.curr_oct > args.oct_range) then
  data.curr_oct = args.oct_range
end]],
},
options = {
 color = 0x935875,
},
callback = [[
-------------------------------------------------------------------------------
-- Arpeggiator model
-- * traditional up/down/ordered/random modes
-- * accepts input via MIDI (enable in Options) 
-- * 'lock' defines if generated pattern is locked to pattern start,
--   streaming progress or time since first keystroke
-------------------------------------------------------------------------------

local note_col_idx = rns.selected_note_column_index

-- figure out whether we should output at all...
if (#xvoices > 0) then

  -- global counter 
  local count = nil
  if (args.lock_to == 1) then -- pattern
    count = xpos.line-1
  elseif (args.lock_to == 2) then -- keystroke
    count = xinc-data.keystroke_xinc
  elseif (args.lock_to == 3) then -- stream
    count = xinc
  end
  
  local do_output = (count % args.stepsize == 0)
  if do_output then     
    local voice_idx = data.get_voice_index()
    local voice = xvoices[voice_idx]
    xline.note_columns[note_col_idx] = {
      note_value = voice.values[1] + (data.curr_oct*12),
      volume_value = voice.values[2],
      instrument_value = rns.selected_instrument_index-1,
    }
  else
    -- clear inbetween output
    xline.note_columns[note_col_idx] = {}
  end
else
  xline.note_columns[note_col_idx] = {}
end
]],
}