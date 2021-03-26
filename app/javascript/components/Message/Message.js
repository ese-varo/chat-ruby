import React from 'react'

const Message = (props) => {
  return (
    <div className="card-body">
      <p className="card-title messager">{props.username}</p>
      <div className="row">
        <div className="content col-sm">{props.content}</div>
        <div className="col-sm">
          <div className="btn-group float-right" role="group">
            // <a className="btn btn-outline-primary btn-sm" id="update-37" href="/conversations/1/messages/37/edit">Update</a>
            // <a className="btn btn-outline-danger btn-sm" id="delete-37" data-remote="true" rel="nofollow" data-method="delete" href="/conversations/1/messages/37">Delete</a>
            <a className="btn btn-outline-primary btn-sm" id="update-37" href="#">Update</a>
            <a className="btn btn-outline-danger btn-sm" id="delete-37" data-remote="true" rel="nofollow" data-method="delete" href="#">Delete</a>
          </div>
        </div>
      </div>
      <div className="card-subtitle mb-2 text-muted">{props.date}</div>
    </div>
  )
}

export default Message
