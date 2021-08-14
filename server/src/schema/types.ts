import { PrismaClient } from '@prisma/client';
import { QueryResolvers } from '../generated/resolvers-types';

export type QueryResolverWithPrisma = QueryResolvers<{ prisma: PrismaClient }>
