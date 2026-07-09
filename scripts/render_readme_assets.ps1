Add-Type -AssemblyName System.Drawing

$AssetDir = Join-Path (Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)) "assets"
New-Item -ItemType Directory -Force -Path $AssetDir | Out-Null

function Color-Hex($hex) {
    $h = $hex.TrimStart("#")
    return [System.Drawing.Color]::FromArgb(
        [Convert]::ToInt32($h.Substring(0, 2), 16),
        [Convert]::ToInt32($h.Substring(2, 2), 16),
        [Convert]::ToInt32($h.Substring(4, 2), 16)
    )
}

function Font-Ui($size, $style = "Regular") {
    $fontStyle = [System.Drawing.FontStyle]::$style
    return New-Object System.Drawing.Font("Segoe UI", $size, $fontStyle, [System.Drawing.GraphicsUnit]::Pixel)
}

function New-Canvas($w, $h) {
    $bmp = New-Object System.Drawing.Bitmap($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
    $g.Clear((Color-Hex "#08111f"))
    return @($bmp, $g)
}

function Brush($hex) {
    return New-Object System.Drawing.SolidBrush((Color-Hex $hex))
}

function Pen-Hex($hex, $w = 2) {
    $p = New-Object System.Drawing.Pen((Color-Hex $hex), $w)
    $p.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $p.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    return $p
}

function Rounded-Path($x, $y, $w, $h, $r) {
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $d = $r * 2
    $path.AddArc($x, $y, $d, $d, 180, 90)
    $path.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
    $path.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
    $path.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
    $path.CloseFigure()
    return $path
}

function Fill-Round($g, $x, $y, $w, $h, $r, $fill, $stroke = $null, $strokeW = 2) {
    $path = Rounded-Path $x $y $w $h $r
    $b = Brush $fill
    $g.FillPath($b, $path)
    $b.Dispose()
    if ($stroke) {
        $p = Pen-Hex $stroke $strokeW
        $g.DrawPath($p, $path)
        $p.Dispose()
    }
    $path.Dispose()
}

function Text($g, $text, $x, $y, $w, $h, $size, $color = "#f8fafc", $style = "Regular", $align = "Near") {
    $font = Font-Ui $size $style
    $brush = Brush $color
    $format = New-Object System.Drawing.StringFormat
    $format.Alignment = [System.Drawing.StringAlignment]::$align
    $format.LineAlignment = [System.Drawing.StringAlignment]::Near
    $rect = New-Object System.Drawing.RectangleF($x, $y, $w, $h)
    $g.DrawString($text, $font, $brush, $rect, $format)
    $format.Dispose()
    $brush.Dispose()
    $font.Dispose()
}

function Line($g, $x1, $y1, $x2, $y2, $color = "#38bdf8", $w = 4) {
    $p = Pen-Hex $color $w
    $g.DrawLine($p, $x1, $y1, $x2, $y2)
    $p.Dispose()
}

function Arrow($g, $x1, $y1, $x2, $y2, $color = "#38bdf8", $w = 4) {
    $p = Pen-Hex $color $w
    $p.CustomEndCap = New-Object System.Drawing.Drawing2D.AdjustableArrowCap(7, 9)
    $g.DrawLine($p, $x1, $y1, $x2, $y2)
    $p.Dispose()
}

function Badge($g, $text, $x, $y, $w, $fill, $stroke = "#334155") {
    Fill-Round $g $x $y $w 38 18 $fill $stroke 2
    Text $g $text ($x + 18) ($y + 8) ($w - 36) 28 17 "#e2e8f0" "Bold" "Center"
}

function Card($g, $title, $body, $x, $y, $w, $h, $accent = "#38bdf8") {
    Fill-Round $g $x $y $w $h 18 "#0f172a" "#26364d" 2
    Fill-Round $g $x $y 8 $h 4 $accent $accent 1
    Text $g $title ($x + 28) ($y + 18) ($w - 44) 34 25 "#f8fafc" "Bold"
    Text $g $body ($x + 28) ($y + 58) ($w - 44) ($h - 68) 19 "#b6c2d2"
}

function Save-Canvas($bmp, $g, $name) {
    $path = Join-Path $AssetDir $name
    $g.Dispose()
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output "Wrote $path"
}

function Draw-Grid($g, $w, $h) {
    $p = Pen-Hex "#132238" 1
    for ($x = 0; $x -lt $w; $x += 40) { $g.DrawLine($p, $x, 0, $x, $h) }
    for ($y = 0; $y -lt $h; $y += 40) { $g.DrawLine($p, 0, $y, $w, $y) }
    $p.Dispose()
}

function Draw-Banner {
    $canvas = New-Canvas 1600 520
    $bmp = $canvas[0]; $g = $canvas[1]
    Draw-Grid $g 1600 520
    Fill-Round $g 42 42 1516 436 30 "#0b1220" "#2b3a55" 3
    Fill-Round $g 92 94 190 42 21 "#123044" "#38bdf8" 2
    Text $g "SOURCE-BACKED" 116 103 142 26 16 "#7dd3fc" "Bold" "Center"
    Text $g "Deploy Strategy" 92 160 760 86 68 "#f8fafc" "Bold"
    Text $g "Advisor" 92 238 760 86 68 "#38bdf8" "Bold"
    Text $g "Antigravity skill for deployment architecture decisions across cloud, PaaS, databases, realtime, AI, IoT, and self-hosted infrastructure." 96 335 780 80 24 "#cbd5e1"
    Badge $g "25 reference nodes" 96 430 230 "#0f2f2a" "#34d399"
    Badge $g "live verification" 350 430 230 "#2b2140" "#a78bfa"
    Badge $g "coverage gate" 604 430 200 "#3a2a0d" "#f59e0b"

    Card $g "Input" "Project type`nTech stack`nBudget and traffic`nCompliance and regions" 980 104 230 250 "#38bdf8"
    Card $g "Skill Engine" "SKILL.md routes to manifest, inventory, domain references, and completion matrix." 1260 104 230 250 "#a78bfa"
    Arrow $g 1210 228 1260 228 "#64748b" 5
    Line $g 1095 354 1095 410 "#38bdf8" 4
    Line $g 1375 354 1375 410 "#a78bfa" 4
    Arrow $g 1095 410 1375 410 "#34d399" 5
    Text $g "Verified architecture output" 1050 430 400 36 24 "#34d399" "Bold" "Center"
    Text $g "v3.2" 1458 72 60 28 20 "#cbd5e1" "Bold"
    Save-Canvas $bmp $g "deploy_skill_banner.png"
}

function Draw-Architecture {
    $canvas = New-Canvas 1600 920
    $bmp = $canvas[0]; $g = $canvas[1]
    Draw-Grid $g 1600 920
    Text $g "Hub-and-Spoke Knowledge Architecture" 70 46 920 60 44 "#f8fafc" "Bold"
    Text $g "The hub stays lean. Detailed knowledge loads only when the project constraints require it." 72 106 980 42 22 "#b6c2d2"

    Card $g "User Request" "Workload, stack, budget, traffic, team, regions, compliance, and operational constraints." 70 205 300 190 "#38bdf8"
    Card $g "SKILL.md Hub" "Classify project, route references, apply hard disqualifiers, enforce output template." 475 185 350 230 "#a78bfa"
    Card $g "Source Layer" "00 Source Manifest`n21 Refresh Workflow`n24 Seed Completion Matrix" 930 130 300 190 "#34d399"
    Card $g "Domain References" "Frontend, backend, DB, BaaS, realtime, mobile, AI, IoT, security, pricing, recipes." 930 390 300 220 "#f59e0b"
    Card $g "Maintenance Scripts" "freshness_audit.py`ncoverage_report.py`nverify_sources.py" 930 690 300 160 "#fb7185"
    Card $g "Recommendation" "Selected stack, cost estimate, setup steps, scaling path, gotchas, rejected alternatives, verification." 1280 335 260 270 "#38bdf8"

    Arrow $g 370 300 475 300 "#38bdf8" 5
    Arrow $g 825 255 930 225 "#34d399" 5
    Arrow $g 825 315 930 500 "#f59e0b" 5
    Arrow $g 825 370 930 760 "#fb7185" 5
    Arrow $g 1230 500 1280 470 "#38bdf8" 5
    Arrow $g 1230 760 1370 605 "#fb7185" 4

    Fill-Round $g 460 505 390 270 20 "#102033" "#26364d" 2
    Text $g "Truth hierarchy" 490 535 300 34 28 "#f8fafc" "Bold"
    Text $g "1. Official pricing / limits`n2. Official docs / security`n3. Changelog / status`n4. Official repos`n5. Third-party discovery only" 490 585 320 165 22 "#cbd5e1"
    Save-Canvas $bmp $g "architecture_flowchart.png"
}

function Draw-Decision {
    $canvas = New-Canvas 1600 1000
    $bmp = $canvas[0]; $g = $canvas[1]
    Draw-Grid $g 1600 1000
    Text $g "Deployment Decision Router" 70 46 760 58 44 "#f8fafc" "Bold"
    Text $g "A fair candidate set is filtered by hard constraints before any platform is recommended." 72 106 940 38 22 "#b6c2d2"

    $leftX = 70
    $midX = 520
    $rightX = 1060
    Card $g "Classify" "STATIC_SITE`nFULLSTACK_SAAS`nREALTIME_APP`nMOBILE_BACKEND`nAI_INFERENCE`nIOT_EDGE`nSELFHOSTED_INFRA" $leftX 190 330 310 "#38bdf8"
    Card $g "Generate Candidates" "Managed PaaS`nHyperscaler services`nSelf-hosted/VPS`nSpecialized services`nBaaS / DB / realtime" $midX 155 360 250 "#a78bfa"
    Card $g "Apply Hard Rules" "WebSockets exclude serverless backends`nHIPAA requires BAA`nBYOC routes to supported platforms`nGPU routes to GPU providers`nStrict EU residency filters regions" $midX 500 360 270 "#fb7185"
    Card $g "Verify Sources" "Official pricing`nRuntime limits`nDocs for relied-on feature`nStatus/changelog`nCompliance/security pages" $rightX 155 360 250 "#34d399"
    Card $g "Final Plan" "Stack table`nMonthly estimate`nWhy this fits`nSetup steps`nScaling path`nGotchas`nRejected alternatives" $rightX 500 360 300 "#f59e0b"

    Arrow $g 400 345 520 280 "#38bdf8" 5
    Arrow $g 700 405 700 500 "#a78bfa" 5
    Arrow $g 880 280 1060 280 "#34d399" 5
    Arrow $g 880 635 1060 635 "#f59e0b" 5
    Arrow $g 1240 405 1240 500 "#34d399" 5

    Fill-Round $g 80 770 1420 150 24 "#101a2c" "#26364d" 2
    Text $g "Decision principle" 112 810 260 34 28 "#f8fafc" "Bold"
    Text $g "Recommend the simplest stack that satisfies the constraints. Verify volatile facts live, or mark them unverified." 390 802 1020 80 25 "#cbd5e1"
    Save-Canvas $bmp $g "decision_matrix.png"
}

function Draw-SystemStack {
    $canvas = New-Canvas 1600 1040
    $bmp = $canvas[0]; $g = $canvas[1]
    Draw-Grid $g 1600 1040
    Text $g "Reference Deployment Stack Model" 70 46 780 58 44 "#f8fafc" "Bold"
    Text $g "The skill composes layers. It does not force one vendor across every project." 72 106 920 38 22 "#b6c2d2"

    Card $g "Edge and Frontend" "CDN, static hosting, SSR, image/cache behavior, domains, TLS." 100 190 320 165 "#38bdf8"
    Card $g "Compute" "Containers, PaaS, serverless, workers, background jobs, cron, queues." 460 190 320 165 "#a78bfa"
    Card $g "Data" "Postgres, MySQL, document DB, KV, vector, object storage, time-series." 820 190 320 165 "#34d399"
    Card $g "Realtime" "WebSockets, pub/sub, presence, media, event streams, broker strategy." 1180 190 320 165 "#f59e0b"

    Card $g "CI/CD and Preview" "Git deploys, build cache, test gates, preview environments, rollback." 100 475 320 165 "#38bdf8"
    Card $g "Security" "Secrets, scanning, RBAC, audit logs, SSO, compliance evidence." 460 475 320 165 "#fb7185"
    Card $g "Observability" "Errors, logs, metrics, uptime, alerting, cost/billing watches." 820 475 320 165 "#a78bfa"
    Card $g "Operations" "Backups, disaster recovery, scaling path, runbooks, ownership boundary." 1180 475 320 165 "#34d399"

    Arrow $g 260 355 260 475 "#38bdf8" 4
    Arrow $g 620 355 620 475 "#a78bfa" 4
    Arrow $g 980 355 980 475 "#34d399" 4
    Arrow $g 1340 355 1340 475 "#f59e0b" 4

    Fill-Round $g 170 770 1260 150 28 "#102033" "#26364d" 2
    Text $g "Output contract" 218 806 260 36 30 "#f8fafc" "Bold"
    Text $g "Selected stack + monthly cost + setup steps + scaling path + gotchas + rejected alternatives + verification sources" 510 802 820 66 27 "#cbd5e1"
    Save-Canvas $bmp $g "system_stack.png"
}

function Draw-Coverage {
    $canvas = New-Canvas 1600 920
    $bmp = $canvas[0]; $g = $canvas[1]
    Draw-Grid $g 1600 920
    Text $g "Research Coverage and Freshness Gate" 70 46 880 58 44 "#f8fafc" "Bold"
    Text $g "The original 10 seed sources are not treated as truth. They feed a measurable completion matrix." 72 106 1080 38 22 "#b6c2d2"

    Card $g "10 Seed Sources" "Vendor blogs, editorial lists, review pages, and official repos." 80 220 300 185 "#38bdf8"
    Card $g "Extract Products" "Every platform or adjacent tool becomes a tracked candidate." 455 220 300 185 "#a78bfa"
    Card $g "Promote Targets" "Official docs, pricing, status, changelog, and repo URLs are added." 830 220 300 185 "#34d399"
    Card $g "Evidence Status" "official-evidence`nmanifest-targeted`ninventory-covered`ndiscovery-only`nblocked-or-low-signal" 1205 220 300 250 "#f59e0b"
    Arrow $g 380 310 455 310 "#38bdf8" 5
    Arrow $g 755 310 830 310 "#a78bfa" 5
    Arrow $g 1130 310 1205 310 "#34d399" 5

    Card $g "coverage_report.py" "Fails if important seed-source products disappear from manifest, inventory, evidence, or completion tracking." 200 590 360 210 "#fb7185"
    Card $g "freshness_audit.py" "Checks research dates, URL presence, reference count, and manifest depth." 620 590 360 210 "#38bdf8"
    Card $g "verify_sources.py" "Enumerates or checks official source URLs; dry-run works in restricted environments." 1040 590 360 210 "#34d399"
    Save-Canvas $bmp $g "research_coverage.png"
}

function Draw-Icon {
    $canvas = New-Canvas 512 512
    $bmp = $canvas[0]; $g = $canvas[1]
    Fill-Round $g 32 32 448 448 72 "#0b1220" "#38bdf8" 6
    Fill-Round $g 94 112 324 70 22 "#102033" "#26364d" 2
    Fill-Round $g 94 222 324 70 22 "#102033" "#26364d" 2
    Fill-Round $g 94 332 324 70 22 "#102033" "#26364d" 2
    Text $g "SRC" 121 130 96 34 28 "#38bdf8" "Bold" "Center"
    Text $g "FIT" 121 240 96 34 28 "#34d399" "Bold" "Center"
    Text $g "RUN" 121 350 96 34 28 "#f59e0b" "Bold" "Center"
    Arrow $g 230 146 350 146 "#38bdf8" 6
    Arrow $g 230 256 350 256 "#34d399" 6
    Arrow $g 230 366 350 366 "#f59e0b" 6
    Text $g "DS" 180 38 152 54 42 "#f8fafc" "Bold" "Center"
    Save-Canvas $bmp $g "deploy_skill_icon.png"
}

Draw-Banner
Draw-Architecture
Draw-Decision
Draw-SystemStack
Draw-Coverage
Draw-Icon
