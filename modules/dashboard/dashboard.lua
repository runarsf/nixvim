function RunCommand(command)
  local handle = assert(io.popen(command, "r"))
  local output = assert(handle:read("*a"))

  handle:close()

  return output:gsub("^(\n+)", ""):gsub("(\n+)$", "")
end

function RemoveAnsiCodes(str)
  return RunCommand("printf '" .. str .. "' | ansi2txt")
end

function GetRandomPokemon(shiny_rate)
  local generate_shiny = math.random() < (shiny_rate or -1) --> use krabby's default if unset
  local pokemon_command = "krabby random --no-title"

  if generate_shiny then
    pokemon_command = pokemon_command .. " --shiny"
  end

  return RunCommand(pokemon_command)
end

function GetPokemonSection()
  local utf8 = require("lua-utf8")

  local pokemon = GetRandomPokemon(0.01)
  local lines = vim.split(pokemon, "\n")
  local height = #lines
  local width = 0

  for _, line in ipairs(lines) do
    local clean_line = RemoveAnsiCodes(line)
    local line_length = utf8.len(clean_line)
    if line_length > width then
      width = line_length or 0
    end
  end

  local pimary = FindPrimaryColor(pokemon)
  local r, g, b = pimary.r, pimary.g, pimary.b
  local hex = string.format("#%02x%02x%02x", r, g, b)

  vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = hex })

  -- FIXME: https://github.com/folke/snacks.nvim/issues/1642
  -- local renderer = "printf '" .. pokemon .. "'"
  local renderer = table.concat({
    "while IFS= read -r line; do",
    "  pad_width=$(( ($(tput cols) - " .. width .. " ) / 2 ));",
    "  indent=$(printf '%*s' $pad_width \"\");",
    '  printf \'%s%s\\n\' "$indent" "$line";',
    "done <<'EOF'",
    pokemon,
    "EOF",
  }, "\n")

  return {
    section = "terminal",
    cmd = renderer,
    height = height,

    -- FIXME: https://github.com/folke/snacks.nvim/issues/1642
    -- width = width,
    -- align = "center",
  }
end

function FindPrimaryColor(str)
  local color_frequencies = {}

  for code in str:gmatch("\27%[(.-)m") do
    local parts = {}

    for part in code:gmatch("[^;]+") do
      parts[#parts + 1] = part
    end

    if #parts >= 5 and (parts[1] == "38" or parts[1] == "48") and parts[2] == "2" then
      local r = tonumber(parts[3])
      local g = tonumber(parts[4])
      local b = tonumber(parts[5])

      if r and g and b then
        local rgb_str = string.format("%d,%d,%d", r, g, b)
        color_frequencies[rgb_str] = (color_frequencies[rgb_str] or 0) + 1
      end
    end
  end

  local best_color = {
    value = { r = 255, g = 255, b = 255 },
    normalized_frequency = 0,
    luminance = 0,
    saturation = 0,
    score = -1,
  }

  local total_pixels = 0
  for _, frequency in pairs(color_frequencies) do
    total_pixels = total_pixels + frequency
  end

  for rgb_str, frequency in pairs(color_frequencies) do
    local r, g, b = rgb_str:match("(%d+),(%d+),(%d+)")
    r, g, b = tonumber(r), tonumber(g), tonumber(b)

    if r and g and b then
      local luminance = (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255 -- https://www.w3.org/WAI/GL/wiki/Relative_luminance

      if luminance > 0.333 then
        local normalized_frequency = frequency / total_pixels
        local hsv = RgbToHsv(r, g, b)
        local saturation = hsv.s

        local frequency_weight = 0.75
        local luminance_weight = 0.05
        local saturation_weight = 0.2

        local score = frequency_weight * normalized_frequency
          + saturation_weight * saturation
          - luminance_weight * luminance

        if score > best_color.score then
          best_color = {
            value = { r = r, g = g, b = b },
            normalized_frequency = normalized_frequency,
            luminance = luminance,
            saturation = saturation,
            score = score,
          }
        end
      end
    end
  end

  return best_color.value
end

function RgbToHsv(r, g, b)
  r, g, b = r / 255, g / 255, b / 255
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local delta = max - min
  local h, s, v = 0, 0, max

  if delta > 0 then
    s = delta / max
    if max == r then
      h = (g - b) / delta
    elseif max == g then
      h = 2 + (b - r) / delta
    else
      h = 4 + (r - g) / delta
    end
    h = (h * 60) % 360
  end

  return {
    h = h / 360,
    s = s,
    v = v,
  }
end
