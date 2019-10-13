const postComment = () => {
  const post = (articleId, content) => {
    var url = `http://localhost:3000/comments`
    // var body = JSON.stringify ({
    //  'article_id': articleId,
    //  'content': content
    // })
    // fetch(url, { method: 'POST', body: body })
    fetch(`${url}?article_id=${articleId}&content=${content}`, { method: 'POST'})
    .then(function(response) {
      return response.blob();
    })
    .then(function(myBlob) {
      console.log(myBlob)
    });
  }

  if (document.querySelector('.comment-input')) {
    document.addEventListener('keyup', (e) => {
      if (e.keyCode === 13 && document.activeElement.classList.contains("comment-input")) {
        var input = document.activeElement
        var articleId = input.dataset.articleId
        var content = input.value

        post(articleId, content)
      }
    })
  }

}


export { postComment }

