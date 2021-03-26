import React from 'react'
import DeleteButton from './DeleteButton'
import UpdateButton from './UpdateButton'

const Content = (props) => {
  return (
    <div className="row">
      <div className="content col-sm">{props.content}</div>
      <div className="col-sm">
        <div className="btn-group float-right" role="group">
          <DeleteButton message_id={props.id} conversation_id={props.conversation_id}/>
          <UpdateButton message_id={props.id} conversation_id={props.conversation_id}/>
        </div>
      </div>
    </div>
  )
}

export default Content
