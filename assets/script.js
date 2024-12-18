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
