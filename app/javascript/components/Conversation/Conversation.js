import React, { Component } from 'react'
import Message from '../Message/Message'

class Conversation extends Component {
  constructor(){
    super()

    this.state = {
      messages: [
        { id: 1, username: 'El fulano', removed: false, content: 'The content', date: '10 of jan' },
        { id: 2, username: 'El aquel', removed: true, content: 'Ora ora', date: '13 of may' },
        { id: 3, username: 'El man', removed: false, content: 'jejeje', date: '15 of aug' },
        { id: 4, username: 'El otro', removed: false, content: 'Especialmente hoy', date: '1 of jun' },
      ]
    }
  }
  render() {
    const messages = this.state.messages.map( (message) => {

      return(
        message.removed ? (
          <div key={message.id} className="d-flex justify-content-end">
            <div className="card mt-3 col-md-8 bg-corn">
              <Message username={message.username} removed={message.removed} content={message.content} date={message.date}/>
            </div>
          </div>
        ) : (
          <div key={message.id} className="d-flex justify-content-start">
            <div className="card mt-3 col-md-8 bg-persian">
              <Message username={message.username} removed={message.removed} content={message.content} date={message.date}/>
            </div>
          </div>
        )
      )
    })

    return (
      <section id="messages" className="chat-box__content">
        {messages}
        <div>This is our Conversation component.</div>
      </section>
    )
  }
}

export default Conversation
