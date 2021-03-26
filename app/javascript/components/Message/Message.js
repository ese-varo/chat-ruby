import React from 'react'
import Content from './Content'
import RemovedContent from './RemovedContent'

const Message = (props) => {
  return (
    props.removed ? (
      <div className="card-body">
        <p className="card-title messager">{props.username}</p>
        <RemovedContent content={props.content} message_id={props.id}/>
        <div className="card-subtitle mb-2 text-muted">{props.date}</div>
      </div>
    ) : (
      <div className="card-body">
        <p className="card-title messager">{props.username}</p>
        <Content content={props.content} id={props.id} conversation_id={props.conversation_id}/>
        <div className="card-subtitle mb-2 text-muted">{props.date}</div>
      </div>
    )
  )
}

export default Message
