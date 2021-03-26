import React from 'react'

const UpdateButton = (props) => {
  const url = `/conversations/${props.conversation_id}/messages/${props.message_id}/edit`

  return (
    <a key={`delete-${props.id}`} className="btn btn-outline-primary btn-sm" href={url}>Update</a>
  )
}

export default UpdateButton
