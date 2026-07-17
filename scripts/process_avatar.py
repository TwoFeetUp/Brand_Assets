#!/usr/bin/env python3
"""
process_avatar.py -- TwoFeetUp employee avatar generator.

Turns a raw head-and-shoulders photo into the canonical TwoFeetUp employee
avatar: a background-free subject silhouette inside the orange TwoFeetUp ring,
on a fully transparent 500x500 canvas. This is the single source of truth for
how an employee avatar is produced, so every colleague (new hire or re-shoot)
comes out identical.

Canonical spec (measured from the existing approved avatars):
  - Canvas      : 500 x 500 px, RGBA, fully transparent background
  - Ring color  : #faa61a (TwoFeetUp Orange, matches manifest.colors.accent)
  - Ring outer  : radius 200 px (touches 50 px from the canvas edge)
  - Ring inner  : radius 189 px  (=> ~11 px thick)
  - Subject     : background removed, sits inside the ring, ring drawn on top

Dependencies (NOT part of the repo -- install in a throwaway venv):
    python3 -m venv .venv && . .venv/bin/activate
    pip install "rembg[cpu]" onnxruntime pillow

Usage:
    python scripts/process_avatar.py input.jpg images/employees/Name.png
    # optional: --no-ring for a plain transparent cutout
    # optional: --scale/--dx/--dy to nudge framing before the ring is applied
"""
import argparse
from PIL import Image, ImageDraw

CANVAS = 500
RING_OUTER = 200
RING_INNER = 189
RING_COLOR = (250, 166, 26, 255)  # #faa61a


def ring_layer(size=CANVAS, outer=RING_OUTER, inner=RING_INNER, color=RING_COLOR, ss=4):
    """Anti-aliased orange ring on a transparent canvas (supersampled)."""
    S = size * ss
    c = S / 2
    im = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.ellipse([c - outer * ss, c - outer * ss, c + outer * ss, c + outer * ss], fill=color)
    d.ellipse([c - inner * ss, c - inner * ss, c + inner * ss, c + inner * ss], fill=(0, 0, 0, 0))
    return im.resize((size, size), Image.LANCZOS)


def cutout(path):
    """Background-removed subject silhouette (rembg u2net_human_seg + alpha matting)."""
    from rembg import remove, new_session
    sess = new_session("u2net_human_seg")
    im = Image.open(path).convert("RGBA")
    return remove(
        im, session=sess, alpha_matting=True,
        alpha_matting_foreground_threshold=240,
        alpha_matting_background_threshold=20,
        alpha_matting_erode_size=2,
    )


def process(src, dst, ring=True, scale=1.0, dx=0, dy=0):
    sil = cutout(src).resize((int(CANVAS * scale), int(CANVAS * scale)))
    canvas = Image.new("RGBA", (CANVAS, CANVAS), (0, 0, 0, 0))
    ox = (CANVAS - sil.width) // 2 + dx
    oy = (CANVAS - sil.height) // 2 + dy
    canvas.alpha_composite(sil, (ox, oy))
    if ring:
        canvas.alpha_composite(ring_layer())
    canvas.save(dst)
    a = canvas.split()[3].getextrema()
    print(f"wrote {dst}  ({CANVAS}x{CANVAS}, alpha {a[0]}-{a[1]})")


if __name__ == "__main__":
    p = argparse.ArgumentParser(description="Generate a canonical TwoFeetUp employee avatar.")
    p.add_argument("src")
    p.add_argument("dst")
    p.add_argument("--no-ring", action="store_true")
    p.add_argument("--scale", type=float, default=1.0)
    p.add_argument("--dx", type=int, default=0)
    p.add_argument("--dy", type=int, default=0)
    a = p.parse_args()
    process(a.src, a.dst, ring=not a.no_ring, scale=a.scale, dx=a.dx, dy=a.dy)
