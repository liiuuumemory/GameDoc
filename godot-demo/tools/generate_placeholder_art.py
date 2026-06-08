from pathlib import Path


OUT_DIR = Path(__file__).resolve().parents[1] / "assets" / "placeholder_2_5d"


def tag(name, attrs=None, body=""):
    attrs = attrs or {}
    attr_text = " ".join(f'{key}="{value}"' for key, value in attrs.items())
    if body:
        return f"<{name} {attr_text}>{body}</{name}>"
    return f"<{name} {attr_text}/>"


def svg_doc(width, height, body):
    return (
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" '
        f'viewBox="0 0 {width} {height}" shape-rendering="geometricPrecision">\n'
        f"{body}\n</svg>\n"
    )


def rect(x, y, w, h, fill, stroke="none", sw=1, rx=0, opacity=1):
    attrs = {"x": x, "y": y, "width": w, "height": h, "fill": fill, "stroke": stroke, "stroke-width": sw, "opacity": opacity}
    if rx:
        attrs["rx"] = rx
    return tag("rect", attrs)


def poly(points, fill, stroke="none", sw=1, opacity=1):
    return tag("polygon", {"points": points, "fill": fill, "stroke": stroke, "stroke-width": sw, "opacity": opacity})


def line(x1, y1, x2, y2, stroke, sw=2, opacity=1):
    return tag("line", {"x1": x1, "y1": y1, "x2": x2, "y2": y2, "stroke": stroke, "stroke-width": sw, "opacity": opacity, "stroke-linecap": "round"})


def circle(cx, cy, r, fill, stroke="none", sw=1, opacity=1):
    return tag("circle", {"cx": cx, "cy": cy, "r": r, "fill": fill, "stroke": stroke, "stroke-width": sw, "opacity": opacity})


def ellipse(cx, cy, rx, ry, fill, opacity=1):
    return tag("ellipse", {"cx": cx, "cy": cy, "rx": rx, "ry": ry, "fill": fill, "opacity": opacity})


def path(d, fill="none", stroke="#a7b0b2", sw=2, opacity=1):
    return tag("path", {"d": d, "fill": fill, "stroke": stroke, "stroke-width": sw, "opacity": opacity, "stroke-linecap": "round", "stroke-linejoin": "round"})


def write_svg(name, width, height, parts):
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    (OUT_DIR / name).write_text(svg_doc(width, height, "\n".join(parts)), encoding="utf-8")


def character(name, coat, trim, skin="#8b8072", child=False, elder=False, formal=False, beacon=False, bag=False):
    h = 96 if child else 112
    top = 18 if not child else 32
    body_top = 48 if not child else 58
    body_bottom = 102 if not child else 104
    parts = [
        rect(0, 0, 96, 128, "none"),
        ellipse(48, 112, 26, 9, "#11161a", 0.42),
        poly("38,102 46,102 44,118 35,118", "#1b2022"),
        poly("51,102 60,101 64,118 54,118", "#1b2022"),
        poly(f"34,{body_top} 60,{body_top-4} 69,{body_bottom} 29,{body_bottom}", coat, "#11161a", 2),
        poly(f"38,{body_top+5} 58,{body_top+1} 57,{body_bottom-8} 41,{body_bottom-4}", trim, opacity=0.55),
        circle(48, top + 16, 13 if not child else 11, skin, "#181b1d", 2),
        poly(f"35,{top+10} 48,{top+2} 61,{top+10} 58,{top+18} 38,{top+18}", "#24282b", opacity=0.85),
        line(36, body_top + 10, 22, body_top + 38, "#202529", 5),
        line(61, body_top + 8, 76, body_top + 34, "#202529", 5),
    ]
    if bag:
        parts += [
            poly("63,65 82,70 80,94 62,90", "#313a3c", "#15191b", 2),
            line(58, 55, 78, 88, "#6f797a", 3, 0.8),
        ]
    if beacon:
        parts += [
            poly("73,74 83,78 80,91 70,87", "#566a70", "#171a1b", 1.5),
            circle(77, 82, 3, "#9db4bd"),
        ]
    if elder:
        parts += [
            line(73, 76, 80, 116, "#6e6258", 3),
            poly("39,42 57,39 64,102 32,103", "#5b5750", opacity=0.35),
        ]
    if formal:
        parts += [
            line(48, 51, 48, 100, "#b8c1c5", 2, 0.55),
            rect(32, 60, 8, 18, "#d3d8d8", opacity=0.5),
        ]
    write_svg(name, 96, 128, parts)


def authority_marker():
    parts = [
        rect(0, 0, 96, 96, "none"),
        ellipse(48, 76, 30, 8, "#11161a", 0.35),
        poly("48,10 76,26 76,60 48,78 20,60 20,26", "#27343a", "#8a9698", 3),
        poly("48,22 63,31 63,52 48,62 33,52 33,31", "#40515a", "#a6b1b2", 2),
        line(35, 44, 61, 44, "#c1c8c8", 3),
        line(48, 28, 48, 60, "#c1c8c8", 3),
    ]
    write_svg("authority_marker.svg", 96, 96, parts)


def floor_asset(name, base, slab, line_color, grime, variant):
    parts = [
        rect(0, 0, 960, 540, base),
        poly("95,86 815,68 925,432 52,486", slab, "#2b3335", 3),
        poly("95,86 815,68 838,108 126,132", "#222a2d", opacity=0.5),
        poly("52,486 925,432 892,486 94,514", "#0f1416", opacity=0.35),
    ]
    for x in range(150, 820, 110):
        parts.append(line(x, 115, x + 80, 455, line_color, 2, 0.22))
    for y in range(150, 445, 70):
        parts.append(line(115, y, 850, y - 28, line_color, 2, 0.22))
    for i, (x, y, w, h) in enumerate([(155, 370, 90, 20), (610, 315, 130, 18), (420, 145, 100, 16)]):
        parts.append(poly(f"{x},{y} {x+w},{y-6} {x+w+18},{y+h} {x+18},{y+h+7}", grime, opacity=0.28 + i * 0.06))
    if variant == "office":
        parts += [
            poly("180,160 330,150 362,215 204,230", "#2f383a", "#161b1d", 2),
            poly("515,150 650,142 676,208 536,220", "#263239", "#15191b", 2),
            line(120, 420, 820, 382, "#4a5354", 3, 0.45),
        ]
    elif variant == "market":
        parts += [
            poly("120,286 840,250 846,266 128,304", "#80773d", opacity=0.75),
            poly("190,170 310,158 336,226 210,242", "#3a302b", "#17191a", 2),
            poly("625,160 745,150 776,222 650,238", "#2e3735", "#17191a", 2),
            line(190, 205, 328, 194, "#59615d", 2, 0.6),
        ]
    elif variant == "old":
        parts += [
            poly("140,150 320,128 344,245 162,268", "#1e2224", "#111416", 2),
            poly("545,115 785,102 805,210 560,230", "#191d20", "#101315", 2),
            poly("620,342 830,326 852,438 636,458", "#171b1e", "#0e1112", 2),
            line(100, 440, 780, 398, "#6a6540", 4, 0.36),
            line(650, 384, 835, 365, "#4b5556", 5, 0.45),
        ]
    elif variant == "gate":
        parts += [
            poly("580,120 855,110 880,425 610,445", "#263039", "#11171b", 2),
            line(620, 165, 840, 154, "#6f858e", 4, 0.55),
            line(620, 220, 846, 210, "#3e4b52", 2, 0.55),
            line(620, 280, 850, 272, "#3e4b52", 2, 0.55),
        ]
    write_svg(name, 960, 540, parts)


def iso_block(name, width, height, tall=False):
    face = "#2b3335"
    top = "#444b4c"
    side = "#1a2022"
    h = 144 if tall else 96
    parts = [
        rect(0, 0, 160, h, "none"),
        poly(f"20,34 118,22 145,45 47,59", top, "#111517", 2),
        poly(f"47,59 145,45 145,{h-24} 47,{h-10}", face, "#111517", 2),
        poly(f"20,34 47,59 47,{h-10} 20,{h-36}", side, "#111517", 2),
        line(56, 70, 132, 60, "#596164", 2, 0.35),
    ]
    write_svg(name, width, height, parts)


def object_asset(name, kind):
    parts = [rect(0, 0, 128, 128, "none"), ellipse(64, 104, 34, 9, "#0d1113", 0.35)]
    if kind == "doorway":
        parts += [
            poly("24,44 94,34 106,94 34,106", "#273136", "#111719", 3),
            poly("40,55 82,50 88,91 45,97", "#101517", "#627074", 2),
            line(90, 48, 102, 42, "#839194", 3, 0.8),
        ]
    elif kind == "terminal_authority":
        parts += [
            poly("36,34 91,29 101,86 43,94", "#263843", "#101719", 2),
            poly("45,43 82,39 88,62 50,67", "#6f8992", "#101719", 1.5, 0.85),
            rect(48, 70, 39, 9, "#1a2226"),
            circle(91, 75, 4, "#9dafb4"),
        ]
    elif kind == "terminal_facility":
        parts += [
            poly("32,32 95,27 103,88 39,98", "#1e3139", "#0e1416", 2),
            poly("43,43 86,39 91,65 47,71", "#879aa0", "#111719", 1.5, 0.85),
            line(50, 79, 89, 74, "#b6c2c5", 2, 0.55),
            line(54, 86, 88, 81, "#b6c2c5", 2, 0.4),
        ]
    elif kind == "beacon":
        parts += [
            poly("54,36 73,41 76,86 51,91", "#354951", "#111719", 2),
            circle(64, 51, 7, "#8ea7ad", "#111719", 1.5),
            line(64, 36, 64, 20, "#87979a", 3),
            line(50, 92, 42, 108, "#20272b", 3),
            line(76, 88, 88, 104, "#20272b", 3),
        ]
    elif kind == "beacon_placed":
        parts += [
            ellipse(64, 88, 36, 15, "#5f7478", 0.22),
            ellipse(64, 88, 50, 21, "#5f7478", 0.12),
            poly("54,36 73,41 76,86 51,91", "#41575e", "#111719", 2),
            circle(64, 51, 7, "#b3c7cb", "#111719", 1.5),
            line(64, 36, 64, 20, "#87979a", 3),
        ]
    elif kind.startswith("scan"):
        color = {"scan_temp": "#8a6e5d", "scan_sensor": "#6b7780", "scan_pipe": "#63756b"}[kind]
        parts += [
            poly("32,48 78,39 96,78 50,92", color, "#111719", 2),
            circle(63, 65, 14, "#1b2225", "#aeb9ba", 2),
        ]
        if kind == "scan_temp":
            parts += [line(63, 56, 63, 72, "#c8b2a0", 3), circle(63, 75, 4, "#c8b2a0")]
        elif kind == "scan_sensor":
            parts += [line(54, 65, 72, 65, "#c0c8c9", 2), line(63, 56, 63, 74, "#c0c8c9", 2)]
        else:
            parts += [path("M51 68 C60 55, 70 78, 79 62", stroke="#c0c8c9", sw=3)]
    elif kind == "notice":
        parts += [
            poly("24,39 95,32 101,83 29,94", "#3a332c", "#121516", 2),
            rect(39, 50, 38, 8, "#9da6a4", opacity=0.65),
            rect(42, 64, 45, 6, "#8b938f", opacity=0.45),
            line(39, 94, 34, 116, "#22292b", 4),
            line(86, 86, 91, 110, "#22292b", 4),
        ]
    elif kind == "clinic":
        parts += [poly("28,47 88,37 101,83 38,96", "#374347", "#121516", 2), line(64, 50, 64, 82, "#aeb7b7", 5), line(50, 66, 78, 66, "#aeb7b7", 5)]
    elif kind == "school":
        parts += [poly("28,47 88,37 101,83 38,96", "#343b36", "#121516", 2), poly("45,58 63,48 82,58 64,68", "#aeb7b7", opacity=0.7), rect(49, 67, 31, 9, "#aeb7b7", opacity=0.55)]
    elif kind == "water":
        parts += [poly("42,42 85,36 92,86 47,95", "#334348", "#121516", 2), path("M64 52 C51 68, 52 81, 65 85 C78 79, 77 66, 64 52Z", fill="#7f9ba4", stroke="#111719", sw=2, opacity=0.9)]
    elif kind == "blocked":
        parts += [poly("24,40 94,33 106,90 34,104", "#24292b", "#101314", 2), line(36, 55, 95, 91, "#6b6256", 5), line(39, 94, 92, 43, "#6b6256", 5)]
    elif kind == "pipe":
        parts += [path("M18 78 C42 52, 83 100, 112 64", stroke="#53615f", sw=14), path("M18 78 C42 52, 83 100, 112 64", stroke="#87918d", sw=3, opacity=0.5), circle(40, 61, 5, "#a4aaa6"), circle(89, 83, 5, "#a4aaa6")]
    elif kind == "shade":
        parts += [poly("27,36 95,31 104,88 35,100", "#26343c", "#101719", 2), line(43, 51, 86, 47, "#849399", 2), line(47, 65, 87, 61, "#849399", 2), circle(88, 77, 5, "#b2bec1")]
    write_svg(name, 128, 128, parts)


def old_status_line():
    parts = [
        rect(0, 0, 320, 64, "none"),
        poly("18,34 298,14 306,28 26,49", "#7f7640", opacity=0.78),
        line(30, 42, 292, 23, "#b3a75e", 3, 0.65),
        line(80, 38, 92, 27, "#222423", 4, 0.5),
        line(180, 31, 194, 20, "#222423", 4, 0.5),
    ]
    write_svg("old_status_line.svg", 320, 64, parts)


def icon_asset(name, kind):
    parts = [rect(0, 0, 64, 64, "none")]
    stroke = "#94a1a3"
    if kind == "orbital":
        parts += [circle(32, 32, 20, "none", stroke, 3), path("M12 32 C22 19, 43 19, 52 32 C42 45, 22 45, 12 32Z", stroke=stroke, sw=2)]
    elif kind == "ground":
        parts += [poly("12,42 32,22 52,42 32,54", "none", stroke, 3), line(21, 42, 43, 42, stroke, 2)]
    elif kind == "note":
        parts += [poly("18,12 45,12 52,20 52,52 18,52", "none", stroke, 3), line(24, 29, 46, 29, stroke, 2), line(24, 39, 42, 39, stroke, 2)]
    elif kind == "report":
        parts += [rect(17, 12, 30, 40, "none", stroke, 3, 2), line(23, 24, 41, 24, stroke, 2), line(23, 34, 41, 34, stroke, 2), line(23, 44, 35, 44, stroke, 2)]
    elif kind == "device":
        parts += [rect(18, 14, 28, 38, "none", stroke, 3, 4), circle(32, 40, 5, "none", stroke, 2), line(26, 24, 38, 24, stroke, 2)]
    elif kind == "warning":
        parts += [poly("32,10 55,52 9,52", "none", "#b9ab79", 3), line(32, 24, 32, 39, "#b9ab79", 3), circle(32, 46, 2, "#b9ab79")]
    elif kind == "resident":
        parts += [circle(32, 22, 8, "none", stroke, 3), path("M18 52 C20 39, 44 39, 46 52", stroke=stroke, sw=3)]
    elif kind == "facility":
        parts += [rect(14, 18, 36, 28, "none", stroke, 3, 2), line(21, 28, 43, 28, stroke, 2), line(21, 36, 36, 36, stroke, 2), circle(44, 38, 3, stroke)]
    write_svg(name, 64, 64, parts)


def main():
    character("surveyor_idle.svg", "#20282c", "#56656a", bag=True)
    character("mara_chen_idle.svg", "#55433d", "#7a6257")
    character("jun_idle.svg", "#3b3f3a", "#6b6a55", child=True, beacon=True)
    character("elder_idle.svg", "#4a4842", "#6a655b", elder=True)
    character("ward_idle.svg", "#293840", "#d2d8d9", formal=True)
    character("generic_resident_idle.svg", "#3f4541", "#626a64")
    authority_marker()

    floor_asset("floor_office.svg", "#15191b", "#202729", "#778082", "#475052", "office")
    floor_asset("floor_market.svg", "#111716", "#18211f", "#727d76", "#51493d", "market")
    floor_asset("floor_old_blocks.svg", "#090d0f", "#111618", "#5f6969", "#3a403f", "old")
    floor_asset("floor_gate_two.svg", "#101619", "#18232a", "#829198", "#394349", "gate")
    iso_block("wall_low.svg", 160, 96, False)
    iso_block("wall_tall.svg", 160, 144, True)
    object_asset("doorway.svg", "doorway")
    object_asset("terminal_authority.svg", "terminal_authority")
    object_asset("terminal_facility.svg", "terminal_facility")
    object_asset("beacon.svg", "beacon")
    object_asset("beacon_placed.svg", "beacon_placed")
    object_asset("scan_marker_temp.svg", "scan_temp")
    object_asset("scan_marker_sensor.svg", "scan_sensor")
    object_asset("scan_marker_pipe.svg", "scan_pipe")
    old_status_line()
    object_asset("notice_board.svg", "notice")
    object_asset("clinic_sign.svg", "clinic")
    object_asset("school_sign.svg", "school")
    object_asset("water_point.svg", "water")
    object_asset("blocked_room.svg", "blocked")
    object_asset("pipe_surface.svg", "pipe")
    object_asset("shade_interface_panel.svg", "shade")

    icon_asset("icon_orbital_layer.svg", "orbital")
    icon_asset("icon_ground_layer.svg", "ground")
    icon_asset("icon_discrepancy_note.svg", "note")
    icon_asset("icon_report_terminal.svg", "report")
    icon_asset("icon_survey_device.svg", "device")
    icon_asset("icon_warning.svg", "warning")
    icon_asset("icon_resident_status.svg", "resident")
    icon_asset("icon_facility_data.svg", "facility")


if __name__ == "__main__":
    main()
