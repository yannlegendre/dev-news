const postComment = () => {
  const post = (articleId, content) => {
    var url = `http://localhost:3000/comments`
    let articleElement = document.querySelector(`[data-article-id="${articleId}"]`)
    // let body = JSON.stringify ({
    //  'article_id': articleId,
    //  'content': content
    // })
    // console.log(body);
    // fetch(url, { method: 'POST', body: body })
    fetch(`${url}?article_id=${articleId}&content=${content}`, { method: 'POST'})
    .then(function(response) {
      return response.json();
    })
    .then(function(data) {
      let nb_com = data.nb_com;
      articleElement.querySelector('.comments-list').innerText = `${data.nb_com} comments`;
      document.activeElement.value = "";
    });
  }

// updater le nombre de commentaires avec la reponse du serveur, en la passant dans du json dans le controller

  if (document.querySelector('.comment-input')) {
    document.addEventListener('keyup', (e) => {
      if (e.keyCode === 13 && document.activeElement.classList.contains("comment-input")) {
        let input = document.activeElement
        let articleId = input.dataset.articleId
        let content = input.value
        post(articleId, content);
      }
    })
  }

}


export { postComment }

