// Three.js scene for the screw visualisation
import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import { C, onTheme, readTheme } from '../core.js';

const V3 = (a) => new THREE.Vector3(a[0], a[1], a[2]);

class Arrow3D {
  constructor(parent, { r = 0.016, head = 0.09, headR = 0.042 } = {}) {
    this.mat = new THREE.MeshStandardMaterial({ roughness: 0.45, metalness: 0.0 });
    this.shaft = new THREE.Mesh(Arrow3D.cyl, this.mat);
    this.cone = new THREE.Mesh(Arrow3D.cone, this.mat);
    this.r = r; this.head = head; this.headR = headR;
    this.g = new THREE.Group(); this.g.add(this.shaft, this.cone); parent.add(this.g);
  }
  set(o, v, color, opacity = 1) {
    const L = Math.hypot(v[0], v[1], v[2]);
    if (L < 1e-4) { this.g.visible = false; return; }
    this.g.visible = true;
    const h = Math.min(this.head, L * 0.45), sl = L - h * 0.92;
    this.mat.color.set(color); this.mat.emissive.set(color); this.mat.emissiveIntensity = 0.42; this.mat.transparent = opacity < 1; this.mat.opacity = opacity; this.mat.depthWrite = opacity >= 1;
    this.g.position.set(o[0], o[1], o[2]);
    this.g.quaternion.setFromUnitVectors(new THREE.Vector3(0, 1, 0), new THREE.Vector3(v[0] / L, v[1] / L, v[2] / L));
    this.shaft.scale.set(this.r, sl, this.r); this.shaft.position.set(0, sl / 2, 0);
    this.cone.scale.set(this.headR, h, this.headR); this.cone.position.set(0, L - h / 2, 0);
  }
  hide() { this.g.visible = false; }
}
Arrow3D.cyl = new THREE.CylinderGeometry(1, 1, 1, 14, 1);
Arrow3D.cone = new THREE.ConeGeometry(1, 1, 22, 1);

export function create(host, lblLayer, S, K) {
  const { field, screw, PTS, Z0 } = K;
  readTheme();
  const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: false, powerPreference: 'high-performance' });
  renderer.setPixelRatio(Math.min(devicePixelRatio || 1, 2));
  renderer.outputColorSpace = THREE.SRGBColorSpace;
  host.insertBefore(renderer.domElement, host.firstChild);
  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(32, 1, 0.05, 100);
  camera.up.set(0, 0, 1);
  camera.position.set(4.3, -4.6, 2.9);

  const hemi = new THREE.HemisphereLight(0xffffff, 0x8899aa, 1.25); hemi.position.set(0, 0, 1); scene.add(hemi);
  const dir = new THREE.DirectionalLight(0xffffff, 1.5); dir.position.set(3, -4, 7); scene.add(dir);

  /* static geometry */
  const gridMat = new THREE.LineBasicMaterial({ transparent: true });
  const gp = [];
  for (let x = -3; x <= 3.001; x += 0.5) gp.push(x, -1.5, 0, x, 3, 0);
  for (let y = -1.5; y <= 3.001; y += 0.5) gp.push(-3, y, 0, 3, y, 0);
  const grid = new THREE.LineSegments(new THREE.BufferGeometry().setAttribute('position', new THREE.Float32BufferAttribute(gp, 3)), gridMat);
  scene.add(grid);
  const axMat = new THREE.LineBasicMaterial({});
  const axes = new THREE.LineSegments(new THREE.BufferGeometry().setAttribute('position', new THREE.Float32BufferAttribute([0, 0, 0, 1.8, 0, 0, 0, 0, 0, 0, 1.8, 0, 0, 0, 0, 0, 0, 1.6], 3)), axMat);
  scene.add(axes);

  // body: unit cube
  const body = new THREE.Group(); scene.add(body);
  const faceMat = new THREE.MeshStandardMaterial({ transparent: true, opacity: 0.1, roughness: 0.8, depthWrite: false, side: THREE.DoubleSide });
  const cubeG = new THREE.BoxGeometry(1, 1, 1); cubeG.translate(0.5, 0.5, 0.5);
  body.add(new THREE.Mesh(cubeG, faceMat));
  const edgeMat = new THREE.LineBasicMaterial({});
  body.add(new THREE.LineSegments(new THREE.EdgesGeometry(cubeG), edgeMat));
  const cornerMat = new THREE.MeshStandardMaterial({ roughness: 0.4 });
  const cornerMeshes = {};
  for (const [k, p] of Object.entries(PTS)) { const m = new THREE.Mesh(new THREE.SphereGeometry(0.035, 20, 14), cornerMat); m.position.set(...p); body.add(m); cornerMeshes[k] = m; }

  // central axis
  const axisMat = new THREE.LineDashedMaterial({ dashSize: 0.12, gapSize: 0.08 });
  const axisLine = new THREE.Line(new THREE.BufferGeometry().setFromPoints([new THREE.Vector3(-3.6, Z0[1], Z0[2]), new THREE.Vector3(3.6, Z0[1], Z0[2])]), axisMat);
  axisLine.computeLineDistances(); scene.add(axisLine);
  const tube = new THREE.Mesh(new THREE.CylinderGeometry(0.012, 0.012, 7.2, 10), new THREE.MeshBasicMaterial({ transparent: true, opacity: 0.25 }));
  tube.rotation.z = Math.PI / 2; tube.position.set(0, Z0[1], Z0[2]); scene.add(tube);

  // reference point
  const refMat = new THREE.MeshStandardMaterial({ roughness: 0.35 });
  const ref = new THREE.Mesh(new THREE.SphereGeometry(0.06, 28, 20), refMat); scene.add(ref);
  const refHalo = new THREE.Mesh(new THREE.SphereGeometry(0.1, 24, 16), new THREE.MeshBasicMaterial({ transparent: true, opacity: 0.14, depthWrite: false })); scene.add(refHalo);
  const hit = new THREE.Mesh(new THREE.SphereGeometry(0.2, 12, 8), new THREE.MeshBasicMaterial({ visible: false })); scene.add(hit);
  const footMat = new THREE.LineDashedMaterial({ dashSize: 0.06, gapSize: 0.05 });
  const foot = new THREE.Line(new THREE.BufferGeometry().setFromPoints([new THREE.Vector3(), new THREE.Vector3()]), footMat); scene.add(foot);

  // disc perpendicular to ω through the reference point
  const discMat = new THREE.MeshBasicMaterial({ transparent: true, opacity: 0.07, side: THREE.DoubleSide, depthWrite: false });
  const disc = new THREE.Mesh(new THREE.CircleGeometry(1.3, 72), discMat); disc.rotation.y = Math.PI / 2; scene.add(disc);
  const discRingMat = new THREE.LineBasicMaterial({ transparent: true, opacity: 0.4 });
  const ringPts = []; for (let i = 0; i <= 96; i++) { const a = (i / 96) * Math.PI * 2; ringPts.push(new THREE.Vector3(0, 1.3 * Math.cos(a), 1.3 * Math.sin(a))); }
  const discRing = new THREE.Line(new THREE.BufferGeometry().setFromPoints(ringPts), discRingMat); scene.add(discRing);
  const discPts = [];
  for (let y = -1.2; y <= 1.201; y += 0.3) for (let z = -1.2; z <= 1.201; z += 0.3) if (Math.hypot(y, z) < 1.22 && Math.hypot(y, z) > 0.05) discPts.push([y, z]);
  const discArrows = discPts.map(() => new Arrow3D(scene, { r: 0.008, head: 0.06, headR: 0.026 }));

  // arrows
  const A = {
    corner: Object.fromEntries(Object.keys(PTS).map((k) => [k, new Arrow3D(scene)])),
    v: new Arrow3D(scene, { r: 0.021, head: 0.12, headR: 0.052 }),
    vw: new Arrow3D(scene, { r: 0.013 }), vp: new Arrow3D(scene, { r: 0.013 }),
    wRef: new Arrow3D(scene, { r: 0.018, head: 0.11, headR: 0.048 }),
    wAxis: new Arrow3D(scene, { r: 0.024, head: 0.13, headR: 0.058 }),
    vAxis: new Arrow3D(scene, { r: 0.02, head: 0.11, headR: 0.05 }),
  };

  // trails (helices)
  const trailMat = new THREE.LineBasicMaterial({ transparent: true, opacity: 0.55 });
  const NTR = 400;
  const trails = Object.keys(PTS).map(() => {
    const g = new THREE.BufferGeometry(); g.setAttribute('position', new THREE.BufferAttribute(new Float32Array(NTR * 3), 3));
    const l = new THREE.Line(g, trailMat); scene.add(l); return l;
  });

  /* labels */
  const LBL = [];
  const mk = (html, cls = '') => { const d = document.createElement('div'); d.className = 'lbl3d ' + cls; d.innerHTML = html; lblLayer.append(d); LBL.push(d); return d; };
  const L = {
    A: mk('A'), B: mk('B'), C: mk('C'), ref: mk('B′'), v: mk(''), w: mk(''), axis: mk('ζ'), Z: mk('Z'), x: mk('x'), y: mk('y'), z: mk('z'),
    vAxis: mk(''),
  };
  const place = (d, p, show = true) => {
    if (!show) { d.style.display = 'none'; return; }
    const v = V3(p).project(camera);
    if (v.z > 1) { d.style.display = 'none'; return; }
    d.style.display = '';
    d.style.left = ((v.x + 1) / 2) * W + 'px'; d.style.top = ((1 - v.y) / 2) * H + 'px';
  };

  /* colours */
  function applyTheme() {
    readTheme();
    scene.background = new THREE.Color(C.surface);
    gridMat.color.set(C.grid); gridMat.opacity = 1;
    axMat.color.set(C.muted);
    edgeMat.color.set(C.ink); faceMat.color.set(C.ink); faceMat.opacity = C.dark ? 0.12 : 0.07;
    cornerMat.color.set(C.ink);
    axisMat.color.set(C.k); tube.material.color.set(C.k);
    refMat.color.set(C.ink); refHalo.material.color.set(C.k);
    footMat.color.set(C.k); discMat.color.set(C.v); discRingMat.color.set(C.v); trailMat.color.set(C.v);
    hemi.intensity = C.dark ? 0.9 : 1.25;
    for (const d of LBL) d.style.color = C.ink;
    [L.x, L.y, L.z].forEach((d) => (d.style.color = C.muted));
    dirty();
  }

  /* controls */
  let W = 1, H = 1;
  const ray = new THREE.Raycaster(), ndc = new THREE.Vector2();
  let dragging = false;
  const cv = renderer.domElement;
  const setNdc = (e) => { const r = cv.getBoundingClientRect(); ndc.set(((e.clientX - r.left) / r.width) * 2 - 1, -((e.clientY - r.top) / r.height) * 2 + 1); ray.setFromCamera(ndc, camera); };
  cv.addEventListener('pointerdown', (e) => {
    setNdc(e);
    if (ray.intersectObject(hit).length) { dragging = true; controls.enabled = false; cv.setPointerCapture(e.pointerId); e.stopImmediatePropagation(); e.preventDefault(); }
  });
  cv.addEventListener('pointermove', (e) => {
    setNdc(e);
    if (!dragging) { if (e.pointerType === 'mouse') cv.style.cursor = ray.intersectObject(hit).length ? 'grab' : 'default'; return; }
    const ex = new THREE.Vector3(1, 0, 0);
    let plane;
    if (Math.abs(ray.ray.direction.dot(ex)) > 0.22) plane = new THREE.Plane(ex, -S.ref[0]);
    else { const n = camera.getWorldDirection(new THREE.Vector3()); plane = new THREE.Plane().setFromNormalAndCoplanarPoint(n, V3(S.ref)); }
    const p = new THREE.Vector3();
    if (ray.ray.intersectPlane(plane, p)) {
      S.ref[1] = Math.max(-1.4, Math.min(2.6, p.y)); S.ref[2] = Math.max(-0.4, Math.min(2.6, p.z));
      K.onRef(); dirty();
    }
  });
  const up = () => { if (dragging) { dragging = false; controls.enabled = true; } };
  cv.addEventListener('pointerup', up); cv.addEventListener('pointercancel', up);

  const controls = new OrbitControls(camera, cv);
  controls.target.set(0.05, 0.85, 0.75);
  controls.enableDamping = true; controls.dampingFactor = 0.09; controls.minDistance = 3; controls.maxDistance = 16;
  controls.enablePan = false; controls.rotateSpeed = 0.8;
  controls.addEventListener('change', () => dirty());

  /* update */
  let isDirty = true;
  function dirty() { isDirty = true; }
  const tmp = new THREE.Vector3();
  function update() {
    const f = field(S.h), kin = S.mode === 'kin';
    const cV = kin ? C.v : C.m, cW = kin ? C.m : C.f, cSoft = kin ? C.vsoft : C.m;
    const vs = 0.5;
    const t = kin ? S.t : 0;
    // body pose
    const a = 1 * t;
    body.rotation.set(a, 0, 0);
    tmp.set(0, Z0[1], Z0[2]).applyAxisAngle(new THREE.Vector3(1, 0, 0), a);
    body.position.set(Z0[0] + S.h * t - tmp.x, Z0[1] - tmp.y, Z0[2] - tmp.z);
    for (const m of Object.values(cornerMeshes)) m.visible = S.layers.pts;
    for (const [k, p0] of Object.entries(PTS)) {
      const p = screw(p0, t, S.h), v = f.vel(p);
      if (S.layers.pts) A.corner[k].set(p, v.map((x) => x * vs), cV); else A.corner[k].hide();
      place(L[k], [p[0] - 0.12, p[1] - 0.05, p[2] + 0.1], S.layers.pts);
    }
    // trails
    Object.values(PTS).forEach((p0, i) => {
      const tr = trails[i];
      tr.visible = S.layers.trails && kin;
      if (!tr.visible) return;
      const arr = tr.geometry.attributes.position.array, t0 = -3.2;
      const n = Math.max(2, Math.round(((t - t0) / 6.4) * (NTR - 1)) + 1);
      for (let j = 0; j < n; j++) { const q = screw(p0, t0 + ((t - t0) * j) / (n - 1), S.h); arr[3 * j] = q[0]; arr[3 * j + 1] = q[1]; arr[3 * j + 2] = q[2]; }
      tr.geometry.setDrawRange(0, n); tr.geometry.attributes.position.needsUpdate = true; tr.geometry.computeBoundingSphere();
    });
    // reference point and its kinemate
    const p = S.ref, v = f.vel(p);
    const vw = [f.w[0] * (f.w[0] * v[0]), 0, 0], vp = [v[0] - vw[0], v[1], v[2]];
    ref.position.set(...p); refHalo.position.set(...p); hit.position.set(...p);
    A.v.set(p, v.map((x) => x * vs), cV);
    if (S.layers.split) {
      A.vp.set(p, vp.map((x) => x * vs), cSoft, 0.95);
      A.vw.set(p.map((x, i) => x + vp[i] * vs), vw.map((x) => x * vs), cSoft, 0.95);
    } else { A.vp.hide(); A.vw.hide(); }
    A.wRef.set(p, [0.62, 0, 0], cW, 0.9);
    place(L.ref, [p[0] - 0.05, p[1] - 0.1, p[2] - 0.17]);
    place(L.v, p.map((x, i) => x + v[i] * vs * 1.08 + (i === 2 ? 0.08 : 0)));
    L.v.innerHTML = kin ? '<b>v</b><sub>B′</sub>' : '<b>M</b><sub>B′</sub>'; L.v.style.color = cV;
    place(L.w, [p[0] + 0.72, p[1], p[2] + 0.08]); L.w.innerHTML = kin ? '<b>ω</b>' : '<b>R</b>'; L.w.style.color = cW;
    // axis
    const ax = S.layers.axis;
    axisLine.visible = ax; tube.visible = ax; foot.visible = ax;
    if (ax) {
      const fp = foot.geometry.attributes.position; fp.setXYZ(0, ...p); fp.setXYZ(1, p[0], Z0[1], Z0[2]); fp.needsUpdate = true; foot.computeLineDistances();
      const zx = Math.max(-2.2, Math.min(2.2, p[0]));
      A.wAxis.set([zx - 0.9, Z0[1], Z0[2]], [0.82, 0, 0], cW);
      A.vAxis.set([zx - 0.9, Z0[1], Z0[2]], [S.h * vs, 0, 0], cV);
      place(L.axis, [3.4, Z0[1], Z0[2] + 0.12]); place(L.Z, [p[0] + 0.05, Z0[1] + 0.04, Z0[2] + 0.16], Math.hypot(p[1] - Z0[1], p[2] - Z0[2]) > 0.12);
      place(L.vAxis, [zx - 0.9 + S.h * vs - 0.1, Z0[1], Z0[2] - 0.16], Math.abs(S.h) > 0.08);
      L.vAxis.innerHTML = kin ? '<b>v</b><sub>ω</sub>' : 'λ<b>R</b>'; L.vAxis.style.color = cV; L.axis.style.color = C.k; L.Z.style.color = C.k;
    } else { A.wAxis.hide(); A.vAxis.hide(); place(L.axis, 0, false); place(L.Z, 0, false); place(L.vAxis, 0, false); }
    // disc
    const ds = S.layers.disc;
    disc.visible = ds; discRing.visible = ds;
    disc.position.set(p[0], Z0[1], Z0[2]); discRing.position.set(p[0], Z0[1], Z0[2]);
    discPts.forEach(([y, z], i) => {
      if (!ds) { discArrows[i].hide(); return; }
      const q = [p[0], Z0[1] + y, Z0[2] + z], vq = f.vel(q);
      discArrows[i].set(q, vq.map((x) => x * 0.26), cV, 0.55);
    });
    place(L.x, [1.95, 0, 0]); place(L.y, [0, 1.95, 0]); place(L.z, [0, 0, 1.75]);
  }

  function resize() {
    const r = host.getBoundingClientRect(); W = Math.max(1, r.width); H = Math.max(1, r.height);
    renderer.setSize(W, H, false); renderer.domElement.style.width = '100%'; renderer.domElement.style.height = '100%';
    camera.aspect = W / H;
    // keep the scene framed on narrow (portrait) stages
    camera.fov = W / H < 1 ? 32 / Math.max(0.55, W / H) : 32;
    camera.updateProjectionMatrix(); dirty();
  }
  const ro = new ResizeObserver(resize); ro.observe(host); resize();
  const offTheme = onTheme(applyTheme); applyTheme();

  let alive = true;
  (function loop(now) {
    if (!alive) return;
    requestAnimationFrame(loop);
    if (S.anim) { S.anim(now); isDirty = true; }
    const moved = controls.update();
    if (moved || isDirty || K.runner.playing) { update(); renderer.render(scene, camera); isDirty = false; }
  })(performance.now());

  return {
    dirty,
    destroy() { alive = false; ro.disconnect(); offTheme(); controls.dispose(); renderer.dispose(); renderer.domElement.remove(); lblLayer.innerHTML = ''; },
  };
}
