import { addResolversToSchema } from '@graphql-tools/schema'
import { loadSchemaSync } from '@graphql-tools/load'
import { GraphQLFileLoader } from '@graphql-tools/graphql-file-loader'
import { join } from 'path'

import { resolvers as userResolvers } from './user'

const schema = loadSchemaSync(join(__dirname, '/**/*.graphql'), {
  loaders: [new GraphQLFileLoader()],
})

const schemaWithResolvers = addResolversToSchema({
  schema,
  resolvers: userResolvers,
})

export default schemaWithResolvers
