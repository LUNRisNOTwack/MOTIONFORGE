MOTION FORGE STUDIO 3.6.0  (by LUNR)

INSTALL
1. Put all MotionForge-Studio-Setup-3.6.0.part files and Join-Setup.bat in one folder.
2. Double-click Join-Setup.bat. It must say "joined correctly".
3. Double-click MotionForge-Studio-Setup-3.6.0.exe. Restart After Effects afterwards.

NEW IN 3.6.0: REPLICA MODE (works with any reference video)
How to use: attach your reference video (mp4 / mov) and, if you want an object swapped, your own image or video, with a short note such as "replaces the ball". Write "recreate this but replace ..." and send. Studio:
 1. Reads the reference's exact size, frame rate and length from the file and builds a comp that matches them (no more different timing).
 2. Keeps the reference footage as the base layer, so timing, look, motion and sound are exactly the original.
 3. Finds the object to replace and follows it frame by frame (no extra software; it works on glowing objects, flat logos, anything with contrast), through size changes and re-finding it after cuts.
 4. Hides the old object with a muted clone patch of the nearby background, and places your asset on the same path and at the same size.
 5. Needs only ONE AI call (reading the reference), so it is much faster than before. Everything else runs locally.
The reply says what was matched and any limits. If frames can't be read (After Effects older than 2022) the asset is placed on the AI's estimated path and Studio says so.

HONEST LIMITS
- The original footage stays in the comp as the base layer: only use references you have the right to use.
- The old object is hidden with a patch of nearby background, not true removal. Busy or moving backgrounds can show a faint seam; check the result.
- Replica mode swaps objects. Other changes (new text, colors, speed) are not part of it yet: ask for them in the next message and they are applied on top of the replica.
- Tracking needs the object to stay visible and have contrast; if it can't be followed, Studio says so and places the asset approximately.
- For references that can't be used as footage (not mp4/mov), Studio builds from scratch with its AI tools (scenes, shapes, gradients, light, text) which can approximate but not exactly match complex videos.
- Not included: AI cut-outs/rotoscoping, video generation, text-to-sound, style transfer, camera tracking, voice features.
Tested here with simulated After Effects and simulated AI on synthetic videos with known object paths and on a real reference clip's frames; not yet on a live After Effects, live Google service or real Windows desktop.

THE AI NEEDS A KEY (only for reading the reference and for non-replica jobs)
Studio shows Google's exact reason if a key is refused. If Google says "free tier is not available for this project", that is a restriction on your Google account/project. Options:
 1. Confirm age verification in your Google Account, or make a key with a different Google account at aistudio.google.com/apikey.
 2. Turn on billing in Google AI Studio.
 3. Groq (free key at console.groq.com/keys, text only; cannot read videos).
Keys are stored only in %ProgramData%\MotionForge\server.env.

ALSO INCLUDED: 3.5 authoring tools (gradients, shapes, stars, light bursts/beams, keyframed paths, any installed plug-in by name), 3.4 model fallback/retry, velocity transitions, live previews, music and sound effects, masks/mattes/keying, tour and Guide.
Sound rights: bundled sounds are not verified for commercial use (see sfx_pack/RIGHTS.json).

IF IT WON'T OPEN
Run "Diagnose Motion Forge Studio" from the Start menu (or Diagnose-Studio.bat) and send MotionForge-Diagnostics.txt from your Desktop to LUNR.
