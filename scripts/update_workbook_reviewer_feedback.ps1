$ErrorActionPreference = "Stop"

function Rgb([int]$r, [int]$g, [int]$b) {
    return $r + (256 * $g) + (65536 * $b)
}

function Set-MinMax-RowHeight($worksheet, [int]$fromRow, [int]$toRow, [double]$minHeight, [double]$maxHeight) {
    for ($row = $fromRow; $row -le $toRow; $row++) {
        $height = [double]$worksheet.Rows.Item($row).RowHeight
        if ($height -lt $minHeight) {
            $worksheet.Rows.Item($row).RowHeight = $minHeight
        } elseif ($height -gt $maxHeight) {
            $worksheet.Rows.Item($row).RowHeight = $maxHeight
        }
    }
}

function Protect-Sheet($worksheet) {
    if ($worksheet.ProtectContents) {
        $worksheet.Unprotect("")
    }
    $worksheet.Protect(
        "",
        $true,   # DrawingObjects
        $true,   # Contents
        $true,   # Scenarios
        $false,  # UserInterfaceOnly
        $true,   # AllowFormattingCells
        $true,   # AllowFormattingColumns
        $true,   # AllowFormattingRows
        $false,  # AllowInsertingColumns
        $false,  # AllowInsertingRows
        $false,  # AllowInsertingHyperlinks
        $false,  # AllowDeletingColumns
        $false,  # AllowDeletingRows
        $false,  # AllowSorting
        $false,  # AllowFiltering
        $false   # AllowUsingPivotTables
    )
}

$root = "C:\Users\levine\Dropbox\PC (2)\Documents\Codex\Sentinel-Firewall"
$canonical = Join-Path $root "submission_package\public_code_and_data\Simulating_sentinel_safe_products.xlsx"
$syncCopy = Join-Path $root "submission_package\supplementary_materials\Simulating_sentinel_safe_products.xlsx"

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false

try {
    $wb = $excel.Workbooks.Open($canonical)

    $instructions = $wb.Worksheets.Item("Instructions")
    $inputs = $wb.Worksheets.Item("Inputs")
    $formulaGuide = $wb.Worksheets.Item("Formula_Guide")
    $results = $wb.Worksheets.Item("Results")
    $topline = $wb.Worksheets.Item("Topline")

    if ($inputs.ProtectContents) { $inputs.Unprotect("") }
    if ($results.ProtectContents) { $results.Unprotect("") }
    if ($topline.ProtectContents) { $topline.Unprotect("") }

    # Instructions
    $instructions.Range("B9").Value2 = "Go to the Inputs sheet. The grey Default column contains the author's modal assumptions and is locked. Enter local values only in the yellow 'Your local value' column. The green 'Active value' column will automatically use your entry when present and otherwise fall back to the default. Excel will warn you if a local value falls outside the suggested Low/High range. Such values are allowed for local adaptation, but they should be used only when you have strong local evidence. The Topline sheet then compares the workbook-default mode-only results with your local mode-only scenario."
    $instructions.Range("B11").Value2 = "Start with parameters local decision-makers are most likely to know or influence: GDP per capita at purchasing power parity (PPP), labour share of national income, survival and mortality timing assumptions, product prices, annual births per screening unit, fixed programme setup costs, prevalence in the targeted area, contact attendance, voucher redemption, merchant stock availability, delivery fidelity, and adherence. Scientific parameters such as blood lead level (BLL)-to-IQ and IQ-to-earnings are grouped separately and marked 'change cautiously'."
    $instructions.Columns("A").ColumnWidth = 22
    $instructions.Columns("B").ColumnWidth = 115
    $instructions.Range("A1:F20").WrapText = $true
    $instructions.Rows("1:20").AutoFit()
    Set-MinMax-RowHeight $instructions 1 20 22 85

    # Inputs wording
    $inputs.Cells.Item(3, 2).Value2 = "GDP per capita at purchasing power parity (PPP)"
    $inputs.Cells.Item(4, 2).Value2 = "Labour share of national income (share of GDP accruing to labour)"
    $inputs.Cells.Item(4, 3).Value2 = "Share of GDP / national income"
    $inputs.Cells.Item(8, 2).Value2 = "Survival from birth to age 65"
    $inputs.Cells.Item(23, 2).Value2 = "Programme overhead markup on product and distribution cost"
    $inputs.Cells.Item(24, 2).Value2 = "National and district fixed programme setup and screening cost per screening unit"
    $inputs.Cells.Item(24, 9).Value2 = "Fully loaded national and district-level sentinel screening and programme setup cost. This is the fixed cost pool spread over the annual birth cohort in one screening unit."
    $inputs.Cells.Item(24, 10).Value2 = "Programme-design assumption informed by X-ray fluorescence (XRF) procurement, supervision, training, coordination, and district operations needs."
    $inputs.Cells.Item(25, 2).Value2 = "Annual births per screening unit"
    $inputs.Cells.Item(25, 9).Value2 = "Annual birth cohort used to spread fixed programme costs. The mode assumes a shared-service model in which X-ray fluorescence (XRF) assets and specialised supervision are used across multiple smaller districts or catchments."
    $inputs.Cells.Item(32, 2).Value2 = "Attendance at antenatal care (ANC) contact"
    $inputs.Cells.Item(36, 2).Value2 = "Health-system delivery fidelity"
    $inputs.Cells.Item(36, 9).Value2 = "Probability that the clinic, outreach platform, or linked distribution channel actually delivers the intended product or counselling to the eligible household once contact occurs."
    $inputs.Cells.Item(39, 2).Value2 = "Approved merchant has safe pot in stock when voucher is presented"
    $inputs.Cells.Item(43, 2).Value2 = "Product-specific blood lead level (BLL) effect sizes"
    $inputs.Cells.Item(51, 2).Value2 = "IQ gain per 1 ug/dL lower developmental blood lead level (BLL)"
    $inputs.Cells.Item(52, 9).Value2 = "Percentage increase in lifetime earnings per IQ point. The mode of 0.005 implies about a 0.5% increase in lifetime earnings for each additional IQ point."
    $inputs.Cells.Item(54, 9).Value2 = "Share of the total cognition-relevant developmental window assigned to the last four months in utero."
    $inputs.Cells.Item(55, 9).Value2 = "Share of the total cognition-relevant developmental window assigned to the first year of life."
    $inputs.Cells.Item(63, 2).Value2 = "Disability-adjusted life years (DALYs) per preterm birth averted"
    $inputs.Cells.Item(64, 2).Value2 = "Adult cardiovascular disability-adjusted life years (DALYs) per 1 ug/dL lifetime lead reduction"
    $inputs.Cells.Item(65, 2).Value2 = "Value of a statistical life year (VSLY) relative to annual productivity"
    $inputs.Cells.Item(66, 2).Value2 = "Disability-adjusted life years (DALYs) per preeclampsia case"

    # Inputs layout and readability
    $inputs.Range("A1:L74").WrapText = $true
    $inputs.Range("A1:L74").VerticalAlignment = -4160  # xlTop
    $inputs.Columns("A").ColumnWidth = 24
    $inputs.Columns("B").ColumnWidth = 42
    $inputs.Columns("C").ColumnWidth = 22
    $inputs.Columns("D").ColumnWidth = 15
    $inputs.Columns("E").ColumnWidth = 15
    $inputs.Columns("F").ColumnWidth = 15
    $inputs.Columns("G").ColumnWidth = 10
    $inputs.Columns("H").ColumnWidth = 10
    $inputs.Columns("I").ColumnWidth = 62
    $inputs.Columns("J").ColumnWidth = 44
    $inputs.Columns("K").ColumnWidth = 28
    $inputs.Rows("1:74").AutoFit()
    Set-MinMax-RowHeight $inputs 1 74 24 92

    # Formula guide
    $formulaGuide.Cells.Item(2, 3).Value2 = "Productivity x growth/discount adjustment from birth to labour entry x (sum of working-year survival and growth/discount terms)."
    $formulaGuide.Cells.Item(3, 3).Value2 = "(GDP per capita at PPP) x (labour share of national income)."
    $formulaGuide.Cells.Item(4, 3).Value2 = "(Unsafe-pot prevalence) x (ANC attendance) x (voucher issued) x (merchant stocked) x (voucher redeemed) x (targeted use) x (1 - residual unsafe-use harm)."
    $formulaGuide.Cells.Item(5, 3).Value2 = "(Relevant prevalence where applicable) x (relevant health-system contact) x (delivery fidelity) x (adherence)."
    $formulaGuide.Cells.Item(5, 4).Value2 = "Delivery fidelity is the probability that the programme actually places the product or counselling in the household's hands once the contact occurs."
    $formulaGuide.Cells.Item(6, 3).Value2 = "(Prenatal child BLL reduction x prenatal developmental share) + (postnatal child BLL reduction x postnatal developmental share reached by the product duration)."
    $formulaGuide.Cells.Item(6, 4).Value2 = "Prenatal share means the share of the total cognition-relevant developmental window assigned to the last four months in utero."
    $formulaGuide.Cells.Item(8, 1).Value2 = "Lifetime earnings gain"
    $formulaGuide.Cells.Item(8, 2).Value2 = "IQ gains raise expected lifetime earnings."
    $formulaGuide.Cells.Item(8, 3).Value2 = "Present value of lifetime earnings x earnings gain per IQ point x IQ gain."
    $formulaGuide.Cells.Item(8, 4).Value2 = "This is the main cognition-channel social benefit."
    $formulaGuide.Cells.Item(9, 1).Value2 = "Benefit-cost ratio (BCR)"
    $formulaGuide.Columns("A").ColumnWidth = 28
    $formulaGuide.Columns("B").ColumnWidth = 36
    $formulaGuide.Columns("C").ColumnWidth = 62
    $formulaGuide.Columns("D").ColumnWidth = 46
    $formulaGuide.Range("A1:H30").WrapText = $true
    $formulaGuide.Rows("1:30").AutoFit()
    Set-MinMax-RowHeight $formulaGuide 1 30 20 78

    # Results wording
    $results.Cells.Item(3, 1).Value2 = "Annual productivity anchor (GDP PPP per capita x labour share of national income)"
    $results.Cells.Item(7, 1).Value2 = "Value assigned to one disability-adjusted life year (DALY) / life-year equivalent"
    $results.Cells.Item(7, 4).Value2 = "US$. Disability-adjusted life year (DALY)-based valuation used only in the health-inclusive calculations."
    $results.Cells.Item(14, 4).Value2 = "Probability that the pot pathway reaches, is redeemed, and is used as intended before applying the residual unsafe-use penalty."
    $results.Cells.Item(15, 4).Value2 = "Probability that the pot pathway reaches, is redeemed, and is used as intended after applying the residual unsafe-use penalty."
    $results.Cells.Item(16, 4).Value2 = "Probability that calcium reaches the mother and is used as intended through antenatal care (ANC)."
    $results.Cells.Item(17, 4).Value2 = "Probability that safe child-feeding utensils reach the child and are used as intended."
    $results.Cells.Item(27, 4).Value2 = "Probability change per mother. Used only in the maternal/neonatal-health-inclusive BCR."
    $results.Cells.Item(28, 4).Value2 = "Probability change per mother. Used only in the maternal/neonatal-health-inclusive BCR."
    $results.Cells.Item(32, 1).Value2 = "Kitchen: benefit-cost ratio (BCR), cognition channel only"
    $results.Cells.Item(33, 1).Value2 = "Kitchen: benefit-cost ratio (BCR), cognition plus maternal and neonatal health channels"
    $results.Cells.Item(34, 1).Value2 = "Kitchen: benefit-cost ratio (BCR), cognition, maternal/neonatal, and cardiovascular health channels"
    $results.Cells.Item(37, 4).Value2 = "Probability that safe maternal kohl reaches the mother and is used as intended."
    $results.Cells.Item(38, 4).Value2 = "Probability that safe infant kohl reaches the infant and is used as intended."
    $results.Cells.Item(46, 4).Value2 = "Probability change per mother. Used only in the maternal/neonatal-health-inclusive BCR."
    $results.Cells.Item(47, 4).Value2 = "Probability change per mother. Used only in the maternal/neonatal-health-inclusive BCR."
    $results.Cells.Item(51, 1).Value2 = "Kohl: benefit-cost ratio (BCR), cognition channel only"
    $results.Cells.Item(52, 1).Value2 = "Kohl: benefit-cost ratio (BCR), cognition plus maternal and neonatal health channels"
    $results.Cells.Item(53, 1).Value2 = "Kohl: benefit-cost ratio (BCR), cognition, maternal/neonatal, and cardiovascular health channels"
    $results.Range("B27:C28,B46:C47").NumberFormat = "0.000000"
    $results.Range("A1:F53").WrapText = $true
    $results.Columns("A").ColumnWidth = 58
    $results.Columns("B").ColumnWidth = 14
    $results.Columns("C").ColumnWidth = 14
    $results.Columns("D").ColumnWidth = 62
    $results.Rows("1:53").AutoFit()
    Set-MinMax-RowHeight $results 1 53 20 76

    # Topline wording
    $topline.Cells.Item(5, 1).Value2 = "Child blood lead level (BLL) reduction during intervention period"
    $topline.Cells.Item(6, 1).Value2 = "Developmentally weighted child blood lead level (BLL) reduction used for cognition calculation"
    $topline.Cells.Item(9, 1).Value2 = "Benefit-cost ratios (BCRs)"
    $topline.Cells.Item(10, 1).Value2 = "Benefit-cost ratio (BCR), cognition channel only"
    $topline.Cells.Item(11, 1).Value2 = "Benefit-cost ratio (BCR), cognition plus maternal and neonatal health channels"
    $topline.Cells.Item(12, 1).Value2 = "Benefit-cost ratio (BCR), cognition, maternal/neonatal health, and cardiovascular health channels"

    # Policy-scale section
    $topline.Cells.Item(14, 1).Value2 = "Policy-scale totals per annual screening-unit birth cohort"
    $topline.Cells.Item(15, 1).Value2 = "Total programme cost for one annual screening-unit birth cohort"
    $topline.Cells.Item(16, 1).Value2 = "Total social benefit for one annual screening-unit birth cohort (total BCR channel)"
    $topline.Cells.Item(17, 1).Value2 = "Net social benefit for one annual screening-unit birth cohort (total BCR channel)"
    $topline.Range("B15:B17").Value2 = "US$ per annual birth cohort"

    $topline.Cells.Item(19, 1).Value2 = "Policy-scale totals per 1,000,000 annual births in hotspot districts"
    $topline.Cells.Item(20, 1).Value2 = "Total programme cost for 1,000,000 annual births"
    $topline.Cells.Item(21, 1).Value2 = "Total social benefit for 1,000,000 annual births (total BCR channel)"
    $topline.Cells.Item(22, 1).Value2 = "Net social benefit for 1,000,000 annual births (total BCR channel)"
    $topline.Range("B20:B22").Value2 = "US$ per 1,000,000 annual births"

    $topline.Range("C15").Formula = '=Results!$B$31*Inputs!$D$25'
    $topline.Range("D15").Formula = '=Results!$C$31*Inputs!$F$25'
    $topline.Range("E15").Formula = '=Results!$B$50*Inputs!$D$25'
    $topline.Range("F15").Formula = '=Results!$C$50*Inputs!$F$25'
    $topline.Range("G15").Formula = '=D15-C15'
    $topline.Range("H15").Formula = '=IFERROR((D15-C15)/C15,0)'
    $topline.Range("I15").Formula = '=F15-E15'
    $topline.Range("J15").Formula = '=IFERROR((F15-E15)/E15,0)'

    $topline.Range("C16").Formula = '=Results!$B$34*Results!$B$31*Inputs!$D$25'
    $topline.Range("D16").Formula = '=Results!$C$34*Results!$C$31*Inputs!$F$25'
    $topline.Range("E16").Formula = '=Results!$B$53*Results!$B$50*Inputs!$D$25'
    $topline.Range("F16").Formula = '=Results!$C$53*Results!$C$50*Inputs!$F$25'
    $topline.Range("G16").Formula = '=D16-C16'
    $topline.Range("H16").Formula = '=IFERROR((D16-C16)/C16,0)'
    $topline.Range("I16").Formula = '=F16-E16'
    $topline.Range("J16").Formula = '=IFERROR((F16-E16)/E16,0)'

    $topline.Range("C17").Formula = '=C16-C15'
    $topline.Range("D17").Formula = '=D16-D15'
    $topline.Range("E17").Formula = '=E16-E15'
    $topline.Range("F17").Formula = '=F16-F15'
    $topline.Range("G17").Formula = '=D17-C17'
    $topline.Range("H17").Formula = '=IFERROR((D17-C17)/ABS(C17),0)'
    $topline.Range("I17").Formula = '=F17-E17'
    $topline.Range("J17").Formula = '=IFERROR((F17-E17)/ABS(E17),0)'

    $topline.Range("C20").Formula = '=Results!$B$31*1000000'
    $topline.Range("D20").Formula = '=Results!$C$31*1000000'
    $topline.Range("E20").Formula = '=Results!$B$50*1000000'
    $topline.Range("F20").Formula = '=Results!$C$50*1000000'
    $topline.Range("G20").Formula = '=D20-C20'
    $topline.Range("H20").Formula = '=IFERROR((D20-C20)/C20,0)'
    $topline.Range("I20").Formula = '=F20-E20'
    $topline.Range("J20").Formula = '=IFERROR((F20-E20)/E20,0)'

    $topline.Range("C21").Formula = '=Results!$B$34*Results!$B$31*1000000'
    $topline.Range("D21").Formula = '=Results!$C$34*Results!$C$31*1000000'
    $topline.Range("E21").Formula = '=Results!$B$53*Results!$B$50*1000000'
    $topline.Range("F21").Formula = '=Results!$C$53*Results!$C$50*1000000'
    $topline.Range("G21").Formula = '=D21-C21'
    $topline.Range("H21").Formula = '=IFERROR((D21-C21)/C21,0)'
    $topline.Range("I21").Formula = '=F21-E21'
    $topline.Range("J21").Formula = '=IFERROR((F21-E21)/E21,0)'

    $topline.Range("C22").Formula = '=C21-C20'
    $topline.Range("D22").Formula = '=D21-D20'
    $topline.Range("E22").Formula = '=E21-E20'
    $topline.Range("F22").Formula = '=F21-F20'
    $topline.Range("G22").Formula = '=D22-C22'
    $topline.Range("H22").Formula = '=IFERROR((D22-C22)/ABS(C22),0)'
    $topline.Range("I22").Formula = '=F22-E22'
    $topline.Range("J22").Formula = '=IFERROR((F22-E22)/ABS(E22),0)'

    $topline.Range("C15:F17,C20:F22").NumberFormat = "$#,##0.00"
    $topline.Range("G15:I17,G20:I22").NumberFormat = "$#,##0.00"
    $topline.Range("H15:J17,H20:J22").NumberFormat = "0.0%"

    # Topline emphasis and readability
    $localFill = Rgb 226 239 218
    $sectionFill = Rgb 221 235 247
    $deltaFill = Rgb 242 242 242
    $strongFill = Rgb 198 224 180

    $topline.Range("D1:D22,F1:F22").Interior.Color = $localFill
    $topline.Range("G1:J22").Interior.Color = $deltaFill
    $topline.Range("A2:J2,A9:J9,A14:J14,A19:J19").Interior.Color = $sectionFill
    $topline.Range("D10:D12,F10:F12,D15:D17,F15:F17,D20:D22,F20:F22").Interior.Color = $strongFill
    $topline.Range("D10:D12,F10:F12,D15:D17,F15:F17,D20:D22,F20:F22").Font.Bold = $true
    $topline.Range("D1,F1,D10:D12,F10:F12,D20:D22,F20:F22").Font.Bold = $true

    $topline.Columns("A").ColumnWidth = 58
    $topline.Columns("B").ColumnWidth = 17
    $topline.Columns("C:F").ColumnWidth = 16
    $topline.Columns("G:J").ColumnWidth = 15
    $topline.Range("A1:J22").WrapText = $true
    $topline.Rows("1:22").AutoFit()
    Set-MinMax-RowHeight $topline 1 22 20 70

    # Protection
    Protect-Sheet $inputs
    Protect-Sheet $results
    Protect-Sheet $topline

    $wb.Save()
    $wb.Close($true)
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($topline) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($results) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($formulaGuide) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($inputs) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($instructions) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($wb) | Out-Null
    $wb = $null

    Copy-Item -LiteralPath $canonical -Destination $syncCopy -Force
}
finally {
    $excel.Quit()
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
    [gc]::Collect()
    [gc]::WaitForPendingFinalizers()
}
