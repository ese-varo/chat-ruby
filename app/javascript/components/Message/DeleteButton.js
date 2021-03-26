import React from 'react'

const DeleteButton = (props) => {
  const url = `/conversations/${props.conversation_id}/messages/${props.message_id}`

  return (
    <a key={`delete-${props.id}`} className="btn btn-outline-danger btn-sm" data-remote="true" rel="nofollow" data-method="delete" href={url}>Delete</a>
  )
}

export default DeleteButton
