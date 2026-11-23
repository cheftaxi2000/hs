// Three.js scene for the Gauss visualisation: planes clipped to a box, pairwise intersection lines, column picture
import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import { C, onTheme, readTheme } from '../core.js';
import { Arrow3D } from './schraube3d.js';

const LO = -1.5, HI = 3.5, CEN = [1, 1, 1];
const corners = [];
for (const x of [LO, HI]) for (const y of [LO, HI]) for (const z of [LO, HI]) corners.push([x, y, z]);
const EDGES = [];
for (let i = 0; i < 8; i++) for (let j = i + 1; j < 8; j++) { const d = corners[i].reduce((s, v, k) => s + (v !== corners[j][k] ? 1 : 0), 0); if (d === 1) EDGES.push([corners[i], corners[j]]); }
const dot = (a, b) => a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
const cross = (a, b) => [a[1] * b[2] - a[2] * b[1], a[2] * b[0] - a[0] * b[2], a[0] * b[1] - a[1] * b[0]];
const nrm = (a) => Math.hypot(a[0], a[1], a[2]);

/** polygon of plane n·x = d inside the box */
function clipPlane(n, d) {
  const pts = [];
  for (const [p, q] of EDGES) {
    const fp = dot(n, p) - d, fq = dot(n, q) - d;
    if ((fp <= 0 && fq > 0) || (fp > 0 && fq <= 0)) { const t = fp / (fp - fq); pts.push([p[0] + t * (q[0] - p[0]), p[1] + t * (q[1] - p[1]), p[2] + t * (q[2] - p[2])]); }
  }
  if (pts.length < 3) return null;
  const c = pts.reduce((s, p) => [s[0] + p[0] / pts.length, s[1] + p[1] / pts.length, s[2] + p[2] / pts.length], [0, 0, 0]);
  const L = nrm(n), nn = n.map((v) => v / L);
  const u0 = Math.abs(nn[0]) < 0.9 ? [1, 0, 0] : [0, 1, 0];
  const u = cross(nn, u0), v = cross(nn, u);
  pts.sort((a, b) => Math.atan2(dot(v, [a[0] - c[0], a[1] - c[1], a[2] - c[2]]), dot(u, [a[0] - c[0], a[1] - c[1], a[2] - c[2]])) - Math.atan2(dot(v, [b[0] - c[0], b[1] - c[1], b[2] - c[2]]), dot(u, [b[0] - c[0], b[1] - c[1], b[2] - c[2]])));
  return { pts, c };
}
/** segment of the line p + t u inside the box */
function clipLine(p, u) {
  let t0 = -1e9, t1 = 1e9;
  for (let k = 0; k < 3; k++) {
    if (Math.abs(u[k]) < 1e-12) { if (p[k] < LO || p[k] > HI) return null; continue; }
    let a = (LO - p[k]) / u[k], b = (HI - p[k]) / u[k]; if (a > b) [a, b] = [b, a];
    t0 = Math.max(t0, a); t1 = Math.min(t1, b);
  }
  if (t0 >= t1) return null;
  return [[p[0] + t0 * u[0], p[1] + t0 * u[1], p[2] + t0 * u[2]], [p[0] + t1 * u[0], p[1] + t1 * u[1], p[2] + t1 * u[2]]];
}
/** intersection line of two planes */
function planeLine(r1, r2) {
  const n1 = r1.slice(0, 3), n2 = r2.slice(0, 3), u = cross(n1, n2), uu = dot(u, u);
  if (uu < 1e-9 * dot(n1, n1) * dot(n2, n2)) return null;
  // p = ((d1 n2 − d2 n1) × u) / |u|²   … standard formula: p = (d1 (n2×u) + d2 (u×n1)) / |u|²
  const a = cross(n2, u), b = cross(u, n1);
  const p = [(r1[3] * a[0] + r2[3] * b[0]) / uu, (r1[3] * a[1] + r2[3] * b[1]) / uu, (r1[3] * a[2] + r2[3] * b[2]) / uu];
  return clipLine(p, u);
}

export function create(host, lblLayer, S, runner) {
  readTheme();
  const renderer = new THREE.WebGLRenderer({ antialias: true });
  renderer.setPixelRatio(Math.min(devicePixelRatio || 1, 2));
  renderer.outputColorSpace = THREE.SRGBColorSpace;
  host.insertBefore(renderer.domElement, host.firstChild);
  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(32, 1, 0.05, 200);
  camera.up.set(0, 0, 1);
  camera.position.set(CEN[0] + 11.8, CEN[1] - 10.2, CEN[2] + 7.4);
  scene.add(new THREE.HemisphereLight(0xffffff, 0x8899aa, 1.2));
  const dl = new THREE.DirectionalLight(0xffffff, 1.3); dl.position.set(4, -6, 9); scene.add(dl);

  // box
  const boxMat = new THREE.LineBasicMaterial({ transparent: true, opacity: 0.5 });
  const bp = []; for (const [p, q] of EDGES) bp.push(...p, ...q);
  const box = new THREE.LineSegments(new THREE.BufferGeometry().setAttribute('position', new THREE.Float32BufferAttribute(bp, 3)), boxMat); scene.add(box);
  // axes
  const axMat = new THREE.LineBasicMaterial({});
  const axes = new THREE.LineSegments(new THREE.BufferGeometry().setAttribute('position', new THREE.Float32BufferAttribute([LO, 0, 0, HI, 0, 0, 0, LO, 0, 0, HI, 0, 0, 0, LO, 0, 0, HI], 3)), axMat); scene.add(axes);

  // planes
  const planes = [0, 1, 2].map(() => {
    const g = new THREE.BufferGeometry(); g.setAttribute('position', new THREE.BufferAttribute(new Float32Array(6 * 3 * 3), 3));
    const mat = new THREE.MeshBasicMaterial({ transparent: true, opacity: 0.22, side: THREE.DoubleSide, depthWrite: false });
    const mesh = new THREE.Mesh(g, mat); scene.add(mesh);
    const eg = new THREE.BufferGeometry(); eg.setAttribute('position', new THREE.BufferAttribute(new Float32Array(7 * 3), 3));
    const emat = new THREE.LineBasicMaterial({});
    const edge = new THREE.Line(eg, emat); scene.add(edge);
    return { mesh, mat, edge, emat };
  });
  // pairwise lines
  const lineMat = new THREE.LineBasicMaterial({});
  const lines = [0, 1, 2].map(() => { const g = new THREE.BufferGeometry(); g.setAttribute('position', new THREE.BufferAttribute(new Float32Array(6), 3)); const l = new THREE.Line(g, lineMat); scene.add(l); return l; });
  // solution
  const solMat = new THREE.MeshStandardMaterial({ roughness: 0.35 });
  const solPt = new THREE.Mesh(new THREE.SphereGeometry(0.11, 32, 24), solMat); scene.add(solPt);
  const solLine = new THREE.Mesh(new THREE.CylinderGeometry(0.035, 0.035, 1, 14), solMat); scene.add(solLine);
  // column picture
  const colArrows = [0, 1, 2].map(() => new Arrow3D(scene, { r: 0.028, head: 0.2, headR: 0.075 }));
  const bArrow = new Arrow3D(scene, { r: 0.034, head: 0.22, headR: 0.085 });
  const chainMat = new THREE.LineDashedMaterial({ dashSize: 0.12, gapSize: 0.08 });
  const chain = new THREE.Line(new THREE.BufferGeometry().setAttribute('position', new THREE.BufferAttribute(new Float32Array(12), 3)), chainMat); scene.add(chain);
  const spanMat = new THREE.MeshBasicMaterial({ transparent: true, opacity: 0.12, side: THREE.DoubleSide, depthWrite: false });
  const span = new THREE.Mesh(new THREE.BufferGeometry().setAttribute('position', new THREE.BufferAttribute(new Float32Array(6 * 3 * 3), 3)), spanMat); scene.add(span);

  // labels
  const mk = (html) => { const d = document.createElement('div'); d.className = 'lbl3d'; d.innerHTML = html; lblLayer.append(d); return d; };
  const L = { z: [mk('Z₁'), mk('Z₂'), mk('Z₃')], a: [mk('<b>a</b><sub>1</sub>'), mk('<b>a</b><sub>2</sub>'), mk('<b>a</b><sub>3</sub>')], b: mk('<b>b</b>'), msg: mk(''), x: mk('x'), y: mk('y'), zz: mk('z') };
  L.msg.style.cssText += ';font:500 13px/1.3 var(--sans);font-style:normal;transform:none;left:16px;top:14px;white-space:normal;max-width:60%';
  let W = 1, H = 1;
  const place = (d, p, show = true) => {
    if (!show || !p) { d.style.display = 'none'; return; }
    const v = new THREE.Vector3(...p).project(camera);
    if (v.z > 1) { d.style.display = 'none'; return; }
    d.style.display = ''; d.style.left = ((v.x + 1) / 2) * W + 'px'; d.style.top = ((1 - v.y) / 2) * H + 'px';
  };

  const ROWC = () => [C.v, C.f, C.m];
  function applyTheme() {
    readTheme();
    scene.background = new THREE.Color(C.surface);
    boxMat.color.set(C.muted); axMat.color.set(C.hair); lineMat.color.set(C.ink); solMat.color.set(C.k); solMat.emissive.set(C.k); solMat.emissiveIntensity = 0.3;
    chainMat.color.set(C.ink); spanMat.color.set(C.muted);
    planes.forEach((p, i) => { p.mat.color.set(ROWC()[i]); p.emat.color.set(ROWC()[i]); p.mat.opacity = C.dark ? 0.26 : 0.2; });
    L.z.forEach((d, i) => (d.style.color = ROWC()[i])); L.a.forEach((d, i) => (d.style.color = ROWC()[i])); L.b.style.color = C.ink; L.msg.style.color = C.ink2;
    [L.x, L.y, L.zz].forEach((d) => (d.style.color = C.muted));
    dirty();
  }

  const controls = new OrbitControls(camera, renderer.domElement);
  controls.target.set(...CEN); controls.enableDamping = true; controls.dampingFactor = 0.09; controls.enablePan = false; controls.minDistance = 6; controls.maxDistance = 30;
  controls.addEventListener('change', () => dirty());

  let isDirty = true; function dirty() { isDirty = true; }
  function update() {
    const M = S.current(), rows = S.mode === 'zeilen';
    const msgs = [];
    planes.forEach((pl, i) => {
      const r = M[i], n = r.slice(0, 3), L2 = nrm(n);
      let poly = null;
      if (rows && L2 > 1e-6) poly = clipPlane(n, r[3]);
      if (rows && L2 <= 1e-6) msgs.push(Math.abs(r[3]) < 1e-6 ? `Z${'₁₂₃'[i]}: 0 = 0, keine Bedingung` : `Z${'₁₂₃'[i]}: 0 = ${r[3].toFixed(2).replace('-', '−')}, Widerspruch`);
      pl.mesh.visible = !!poly; pl.edge.visible = !!poly;
      if (!poly) { place(L.z[i], null, false); return; }
      const P = poly.pts, a = pl.mesh.geometry.attributes.position.array;
      let k = 0; for (let j = 1; j < P.length - 1; j++) for (const q of [P[0], P[j], P[j + 1]]) { a[k++] = q[0]; a[k++] = q[1]; a[k++] = q[2]; }
      pl.mesh.geometry.setDrawRange(0, (P.length - 2) * 3); pl.mesh.geometry.attributes.position.needsUpdate = true; pl.mesh.geometry.computeBoundingSphere();
      const e = pl.edge.geometry.attributes.position.array; k = 0;
      for (const q of [...P, P[0]]) { e[k++] = q[0]; e[k++] = q[1]; e[k++] = q[2]; }
      pl.edge.geometry.setDrawRange(0, P.length + 1); pl.edge.geometry.attributes.position.needsUpdate = true; pl.edge.geometry.computeBoundingSphere();
      // label at the polygon vertex farthest from the centre of the box
      let best = P[0], bd = -1; for (const q of P) { const d = Math.hypot(q[0] - CEN[0], q[1] - CEN[1], q[2] - CEN[2] * 0.6); if (d > bd && q[2] >= HI - 0.01) { bd = d; best = q; } }
      if (bd < 0) best = P.reduce((m, q) => (q[2] > m[2] ? q : m), P[0]);
      place(L.z[i], best);
    });
    // pairwise intersection lines
    [[0, 1], [1, 2], [0, 2]].forEach(([i, j], k) => {
      const ln = rows && S.layers.lines && nrm(M[i].slice(0, 3)) > 1e-6 && nrm(M[j].slice(0, 3)) > 1e-6 ? planeLine(M[i], M[j]) : null;
      lines[k].visible = !!ln;
      if (ln) { const a = lines[k].geometry.attributes.position; a.setXYZ(0, ...ln[0]); a.setXYZ(1, ...ln[1]); a.needsUpdate = true; lines[k].geometry.computeBoundingSphere(); }
    });
    box.visible = rows && S.layers.box;
    // solution set (does not change during elimination)
    const so = S.sol;
    solPt.visible = so.kind === 'punkt'; solLine.visible = rows && so.kind === 'gerade';
    if (so.kind === 'punkt') solPt.position.set(...(rows ? so.p : M.map((r) => r[3])));
    if (rows && so.kind === 'gerade') {
      const seg = clipLine(so.p, so.u);
      if (seg) { const a = new THREE.Vector3(...seg[0]), b = new THREE.Vector3(...seg[1]); solLine.position.copy(a.clone().add(b).multiplyScalar(0.5)); solLine.scale.set(1, a.distanceTo(b), 1); solLine.quaternion.setFromUnitVectors(new THREE.Vector3(0, 1, 0), b.clone().sub(a).normalize()); }
    }
    if (rows && so.kind === 'leer') msgs.push('Keine gemeinsame Lösung: Die Ebenen haben keinen Punkt gemeinsam.');
    // column picture
    const cols = [0, 1, 2].map((j) => M.map((r) => r[j])), b = M.map((r) => r[3]);
    colArrows.forEach((ar, j) => { if (rows) ar.hide(); else ar.set([0, 0, 0], cols[j], ROWC()[j]); place(L.a[j], rows ? null : cols[j].map((v) => v * 1.12 + 0.05)); });
    if (rows) bArrow.hide(); else bArrow.set([0, 0, 0], b, C.ink);
    place(L.b, rows ? null : b.map((v) => v * 1.08 + 0.06));
    chain.visible = !rows && so.kind !== 'leer'; span.visible = !rows && so.rank < 3;
    if (!rows && so.kind !== 'leer') {
      const x = so.kind === 'punkt' ? so.p : so.p; const a = chain.geometry.attributes.position;
      let p = [0, 0, 0]; a.setXYZ(0, ...p);
      for (let j = 0; j < 3; j++) { p = p.map((v, k) => v + x[j] * cols[j][k]); a.setXYZ(j + 1, ...p); }
      a.needsUpdate = true; chain.computeLineDistances(); chain.geometry.computeBoundingSphere();
      msgs.push(`x·a₁ + y·a₂ + z·a₃ = b mit (x, y, z) = (${x.map((v) => (+v.toFixed(2)).toString().replace('-', '−')).join(', ')})${so.kind === 'gerade' ? ', eine von unendlich vielen Lösungen' : ''}`);
    }
    if (!rows && so.rank < 3) {
      // the plane spanned by the columns
      const nn = cross(cols[0], cols[1]).some((v) => Math.abs(v) > 1e-6) ? cross(cols[0], cols[1]) : cross(cols[0], cols[2]);
      const poly = clipPlane(nn, 0);
      if (poly) { const P = poly.pts, a = span.geometry.attributes.position.array; let k = 0; for (let j = 1; j < P.length - 1; j++) for (const q of [P[0], P[j], P[j + 1]]) { a[k++] = q[0]; a[k++] = q[1]; a[k++] = q[2]; } span.geometry.setDrawRange(0, (P.length - 2) * 3); span.geometry.attributes.position.needsUpdate = true; span.geometry.computeBoundingSphere(); }
      if (so.kind === 'leer') msgs.push('Die Spalten spannen nur eine Ebene auf (grau), und b liegt nicht darin: keine Linearkombination trifft b.');
    }
    L.msg.innerHTML = msgs.join('<br>'); L.msg.style.display = msgs.length ? '' : 'none';
    place(L.x, [HI + 0.25, 0, 0]); place(L.y, [0, HI + 0.25, 0]); place(L.zz, [0, 0, HI + 0.25]);
  }

  function resize() {
    const r = host.getBoundingClientRect(); W = Math.max(1, r.width); H = Math.max(1, r.height);
    renderer.setSize(W, H, false); renderer.domElement.style.width = '100%'; renderer.domElement.style.height = '100%';
    camera.aspect = W / H; camera.fov = W / H < 1 ? 32 / Math.max(0.55, W / H) : 32; camera.updateProjectionMatrix(); dirty();
  }
  const ro = new ResizeObserver(resize); ro.observe(host); resize();
  const off = onTheme(applyTheme); applyTheme();
  let alive = true;
  (function loop() {
    if (!alive) return; requestAnimationFrame(loop);
    const moved = controls.update();
    if (moved || isDirty || runner.playing) { update(); renderer.render(scene, camera); isDirty = false; }
  })();
  return { dirty, destroy() { alive = false; ro.disconnect(); off(); controls.dispose(); renderer.dispose(); renderer.domElement.remove(); lblLayer.innerHTML = ''; } };
}
