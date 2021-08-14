import { ApolloServer } from 'apollo-server'
import { config } from 'dotenv'

import { createContext } from './context'
import schema from './schema'

config()
const { SERVER_PORT } = process.env

new ApolloServer({ schema, context: createContext }).listen(
  { port: SERVER_PORT },
  () => console.log(`🚀 Server ready at: http://localhost:${SERVER_PORT}`),
)
