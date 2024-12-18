# PowerShell Script to Generate a Basic Learning Blog Structure

# Define the root folder
$RootFolder = "my-learning-blog"

# Define folder structure
$Folders = @(
    "$RootFolder/assets",
    "$RootFolder/data",
    "$RootFolder/images"
)

# Create folders
foreach ($folder in $Folders) {
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
}

# Create initial files
$Files = [ordered]@{}

$Files["$RootFolder/index.html"] = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Learning Blog</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
    <h1>My Learning Blog</h1>
    <div id="blog-container"></div>

    <script src="assets/script.js"></script>
</body>
</html>
'@

$Files["$RootFolder/assets/style.css"] = @'
/* Basic styles */
body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    padding: 2rem;
}

h1 {
    text-align: center;
}

.post {
    margin-bottom: 2rem;
    padding: 1rem;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.post img {
    width: 100%;
    height: auto;
    max-height: 300px;
    object-fit: cover;
    border-radius: 5px;
}

.post h2 {
    margin-top: 0;
}
'@

$Files["$RootFolder/assets/script.js"] = @'
document.addEventListener("DOMContentLoaded", () => {
    const blogContainer = document.getElementById("blog-container");

    // Fetch posts from JSON
    fetch("data/posts.json")
        .then(response => response.json())
        .then(posts => {
            posts.forEach(post => {
                const postElement = document.createElement("div");
                postElement.classList.add("post");
                postElement.innerHTML = `
                    <h2>${post.title}</h2>
                    <p><em>${post.date}</em></p>
                    <img src="${post.image}" alt="${post.title}">
                    <p>${post.content}</p>
                `;
                blogContainer.appendChild(postElement);
            });
        })
        .catch(error => console.error("Error loading posts:", error));
});
'@

$Files["$RootFolder/data/posts.json"] = @'
[
  {
    "id": 1,
    "title": "Welcome to My Learning Blog",
    "date": "2024-12-18",
    "tags": ["introduction"],
    "content": "This is my first blog post where I share my learning journey!",
    "image": "images/welcome.png"
  },
  {
    "id": 2,
    "title": "Understanding WebGL2 Basics",
    "date": "2024-12-19",
    "tags": ["WebGL2", "3D Graphics"],
    "content": "In this post, I explore the basics of WebGL2, including how to set up a simple 3D scene.",
    "image": "images/webgl2.png"
  }
]
'@

# Create files with content
foreach ($FilePath in $Files.Keys) {
    Set-Content -Path $FilePath -Value $Files[$FilePath] -Force
}

Write-Output "Blog structure created successfully in '$RootFolder'!"