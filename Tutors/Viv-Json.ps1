$genre = Get-Content Genres.json | ConvertFrom-Json

$genre

$users = Invoke-RestMethod "https://jsonplaceholder.typicode.com/todos"

$users
