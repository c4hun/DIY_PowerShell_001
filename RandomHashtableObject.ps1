# Définir la liste
$Liste = @("pomme", "banane", "cerise", "mangue", "kiwi")

# Choix de l'utilisateur via `Read-Host`
for ($i = 0;
    $i -lt $Liste.Length; $i++
){
    Write-Host "$($i+1).$($Liste[$i])"
}

# Vérifie si la valeur est un entier valide 
do {
    $Index = Read-Host "Choisis une chiffre entre 1 et $($Liste.Count)"

    if ($Index -match '^\d+$' -and [int]$Index -ge 1 -and [int]$Index -le $Liste.Count){
        $ChoixUtilisateur = $Liste[$Index - 1]
        Write-Host "O:::Tu as choisi: $ChoixUtilisateur"
        $EntreeValide = $True
    }else {
        Write-Host "X:::Choix interdit: entre une chiffre de 1 et $($Liste.Count)"
        $EntreeValide = $False
    }
} while (-not $EntreeValide)

# Choix aléatoire de l'ordinateur 
$ChoixOrdinateur = Get-Random -InputObject $Liste

# Affichage des résultats avec les conditions
if ($ChoixUtilisateur -eq $ChoixOrdinateur){
    Write-Host "SALADE :/"
} else {
    Write-Host "YAOUR :3"
}