import React, { Component } from 'react'
import Message from '../Message/Message'
import axios from 'axios'

class Conversation extends Component {
  constructor(){
    super()

    this.state = {
      conversation_messages: []
    }
  }

  componentDidMount(){
    const queryString = window.location.href.split('/')
    const conversation_id = queryString[queryString.length - 1]
    const url = `/conversations/${conversation_id}.json`

    this.getMessages(url)
  }

  getMessages = async (url) => {
    try {
      const resp = await axios.get(url)
      this.setState({conversation_messages: resp.data})
    } catch (err) {
      console.error(err)
    }
  }

  render() {
    const messages = this.state.conversation_messages.map( (message) => {
      return(
        message.current_user ? (
          <div key={message.id} className="d-flex justify-content-end">
            <div className="card mt-3 col-md-8 bg-corn">
              <Message id={message.id} conversation_id={message.conversation_id}
                       username={message.username} removed={message.removed}
                       content={message.content} date={message.date}/>
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
      </section>
    )
  }
}

export default Conversation
