$outDocx = 'C:\Anshika_Portfolio\assets\resume\Anshika_Gupta_Clean.docx'
$outPdf  = 'C:\Anshika_Portfolio\assets\resume\latest-resume.pdf'

# Kill any stale Word processes
Get-Process WINWORD -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc  = $word.Documents.Add()
$sel  = $word.Selection

$ps = $doc.PageSetup
$ps.TopMargin    = $word.InchesToPoints(0.6)
$ps.BottomMargin = $word.InchesToPoints(0.6)
$ps.LeftMargin   = $word.InchesToPoints(0.75)
$ps.RightMargin  = $word.InchesToPoints(0.75)

function sf($s,$sz,$b=0,$c=0x1a1a1a){ $s.Font.Name='Calibri';$s.Font.Size=$sz;$s.Font.Bold=$b;$s.Font.Color=$c }
function nl($s){ $s.TypeParagraph() }
function txt($s,$t){ $s.TypeText($t) }

function para($s,$t,$sz=10.5,$b=0,$c=0x1a1a1a,$sb=0,$sa=3){
    $s.ParagraphFormat.Alignment=1;$s.ParagraphFormat.SpaceBefore=$sb;$s.ParagraphFormat.SpaceAfter=$sa
    sf $s $sz $b $c; txt $s $t; nl $s
}

function heading($s,$t){
    $s.ParagraphFormat.Alignment=1;$s.ParagraphFormat.SpaceBefore=10;$s.ParagraphFormat.SpaceAfter=3
    sf $s 11 1 0x1d4e89; txt $s $t.ToUpper(); nl $s
    $p=$s.Paragraphs.Last; $bdr=$p.Borders.Item(3)
    $bdr.LineStyle=1;$bdr.LineWidth=6;$bdr.Color=0x1d4e89
}

function job($s,$title,$company,$dates){
    $s.ParagraphFormat.SpaceBefore=8;$s.ParagraphFormat.SpaceAfter=1;$s.ParagraphFormat.Alignment=1
    sf $s 10.5 1 0x1a1a1a; txt $s $title
    sf $s 10.5 0 0x555555
    if($company){ txt $s "  |  $company" }
    nl $s
    $s.ParagraphFormat.SpaceBefore=0;$s.ParagraphFormat.SpaceAfter=3
    sf $s 10 0 0x666666; txt $s $dates; nl $s
}

function bullet($s,$t){
    $s.ParagraphFormat.Alignment=1;$s.ParagraphFormat.SpaceBefore=1;$s.ParagraphFormat.SpaceAfter=2
    $s.ParagraphFormat.LeftIndent=$word.InchesToPoints(0.25)
    $s.ParagraphFormat.FirstLineIndent=$word.InchesToPoints(-0.2)
    sf $s 10.5 0 0x1a1a1a; txt $s ([char]0x2022+"  "+$t); nl $s
    $s.ParagraphFormat.LeftIndent=0;$s.ParagraphFormat.FirstLineIndent=0
}

function skillrow($s,$label,$skills){
    $s.ParagraphFormat.Alignment=1;$s.ParagraphFormat.SpaceBefore=3;$s.ParagraphFormat.SpaceAfter=3
    sf $s 10.5 1 0x1d4e89; txt $s "${label}:  "
    sf $s 10.5 0 0x1a1a1a; txt $s $skills; nl $s
}

# ── NAME HEADER ─────────────────────────────────────────────────────────────
$sel.ParagraphFormat.SpaceBefore=0;$sel.ParagraphFormat.SpaceAfter=4;$sel.ParagraphFormat.Alignment=1
sf $sel 24 1 0x1d4e89; txt $sel 'Anshika Gupta'; nl $sel

$sel.ParagraphFormat.SpaceAfter=4;$sel.ParagraphFormat.Alignment=1
sf $sel 12 0 0x444444; txt $sel 'SDET  |  QA Automation Engineer  |  6+ Years'; nl $sel

$sel.ParagraphFormat.SpaceAfter=2
sf $sel 10 0 0x555555
txt $sel 'guptaanshika987@gmail.com   |   +91-9643522326   |   linkedin.com/in/professional-anshgupta   |   Noida, India'
nl $sel

# ── PROFESSIONAL SUMMARY ────────────────────────────────────────────────────
heading $sel 'Professional Summary'
para $sel 'SDET and QA Automation Specialist with 6+ years of experience designing scalable test automation frameworks for enterprise PLM, SLM, and IIoT applications. Proven expertise in Selenium WebDriver, Java, TestNG, Rest Assured, and Cucumber BDD with CI/CD integration via Jenkins. Delivered a 30% reduction in regression cycle time and validated 100+ product features across UI, API, and data layers using Page Object Model (POM) and data-driven testing in Agile Scrum environments at a Fortune 500 organization.'

# ── TECHNICAL SKILLS ────────────────────────────────────────────────────────
heading $sel 'Technical Skills'
skillrow $sel 'Automation'      'Selenium WebDriver, Java, TestNG, Rest Assured, Cucumber (BDD), Page Object Model (POM), Data-Driven Testing'
skillrow $sel 'API & Tools'     'Postman, Swagger, REST API, JIRA, Zephyr, Maven, Intellicus'
skillrow $sel 'CI/CD & DevOps'  'Jenkins, Kubernetes, Git, Bitbucket, Octopus'
skillrow $sel 'Databases'       'SQL, Oracle, Snowflake, SQL Server, DBeaver'
skillrow $sel 'Testing Types'   'Regression, Smoke, Sanity, Functional, End-to-End, API Testing'

# ── PROFESSIONAL EXPERIENCE ─────────────────────────────────────────────────
heading $sel 'Professional Experience'

job $sel 'Quality Analyst' 'Servigistics R&D Team  |  PTC Inc (Fortune 500 — Global PLM/SLM Leader)' 'Jul 2022 – Present  |  Noida, India'
bullet $sel 'Designed a Selenium WebDriver + TestNG Page Object Model (POM) framework for the Servigistics SPM product suite, reducing regression execution time by 30%.'
bullet $sel 'Automated end-to-end UI and REST API test coverage using Rest Assured and Postman with Cucumber BDD integration for enterprise SLM and PLM workflows.'
bullet $sel 'Integrated full automation test suites into Jenkins CI/CD pipelines, enabling continuous quality validation across Dev, QA, and Staging environments.'
bullet $sel 'Executed Sanity, Smoke, Regression, and Functional test cycles and triaged defects using JIRA and Zephyr with detailed sprint-based reporting.'
bullet $sel 'Provisioned test environments using Kubernetes and configured SQL, Oracle, and Snowflake databases across Windows and Linux server environments.'
bullet $sel 'Developed an auto-upgrade automation job, eliminating manual overhead for environment release upgrades across the Servigistics platform.'
bullet $sel 'Led test estimation, sprint planning, and QA mentoring across cross-functional Agile Scrum teams.'
bullet $sel 'Enhanced data analysis and decision-making using Intellicus and validated forecasting accuracy using SQL statistical methods.'

job $sel 'Software QA Engineer' 'Coforge' 'Jul 2019 – Jul 2022  |  Noida, India'
bullet $sel 'Built reusable POM-based Selenium Java automation scripts with data-driven testing via TestNG, ensuring high maintainability and scalable test coverage.'
bullet $sel 'Delivered end-to-end API and UI validation for 100+ product features, contributing to a 25% improvement in user satisfaction scores.'
bullet $sel 'Managed full test lifecycle using JIRA and Zephyr for defect tracking, test case management, and release reporting across multiple Agile sprints.'
bullet $sel 'Collaborated across 5 cross-functional Agile teams, consistently achieving sprint quality milestones and on-time release readiness.'
bullet $sel 'Maintained version control using Git and Bitbucket; integrated automated tests into CI/CD pipelines for faster delivery cycles.'
bullet $sel 'Validated ETL pipelines and data integrity using SQL Server queries across financial data workflows.'

# ── PROJECTS ────────────────────────────────────────────────────────────────
heading $sel 'Projects'

job $sel 'HYPERNOVA' '' 'Dec 2019 – Jul 2020'
bullet $sel 'Analysed requirement documents and developed comprehensive test cases covering all functional and edge-case scenarios.'
bullet $sel 'Prepared Test Plans; executed Regression testing and defect tracking via JIRA and Zephyr.'

job $sel 'DAAS (Data as a Service)' '' 'Aug 2020 – Sep 2021'
bullet $sel 'Built web automation test cases using Selenium WebDriver + TestNG POM for 80+ identified automation scenarios.'
bullet $sel 'Performed SQL-based data validation and ETL pipeline quality checks.'

job $sel 'MUTUALFUNDDESK' '' 'Nov 2021 – Mar 2022'
bullet $sel 'Participated in Scrum ceremonies — sprint planning, retrospectives, and sprint health analysis.'
bullet $sel 'Delivered product demos to the Product Owner before sprint sign-off, ensuring quality and requirement alignment.'

job $sel 'SERVIGISTICS (SPM)' '' 'Jul 2022 – Present'
bullet $sel 'Validated forecasting data accuracy using SQL and statistical methods (average, weighted average, trend analysis).'
bullet $sel 'Participated in forecasting workflows to predict future product demand based on historical data.'

# ── EDUCATION ───────────────────────────────────────────────────────────────
heading $sel 'Education'

job $sel 'B.Tech' 'Dr. A.P.J. Abdul Kalam Technical University (AKTU)' '2015 – 2019'
para $sel 'Aggregate: 77%' 10.5 0 0x555555 0 6

job $sel 'Intermediate (12th Standard)' '' '2015'
para $sel 'Percentage: 72.3%' 10.5 0 0x555555 0 4

# ── SAVE ────────────────────────────────────────────────────────────────────
$doc.SaveAs([ref]$outDocx, [ref]16)
$doc.SaveAs([ref]$outPdf,  [ref]17)
$doc.Close([ref]$false)
$word.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null

Write-Output "DONE"
Write-Output "PDF:  $(Test-Path $outPdf)  |  $([math]::Round((Get-Item $outPdf).Length/1KB,1)) KB"
Write-Output "DOCX: $(Test-Path $outDocx) |  $([math]::Round((Get-Item $outDocx).Length/1KB,1)) KB"
