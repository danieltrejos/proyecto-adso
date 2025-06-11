import { ApiProperty } from '@nestjs/swagger';

export class Company {
  @ApiProperty()
  id: string;

  @ApiProperty()
  name: string;

  @ApiProperty()
  registrationNumber: string;

  @ApiProperty()
  email: string;
  @ApiProperty({ required: false })
  phone: string | null;

  @ApiProperty()
  currency: string;

  @ApiProperty()
  timezone: string;

  @ApiProperty({ required: false })
  logo: string | null;

  @ApiProperty()
  street: string;

  @ApiProperty()
  city: string;

  @ApiProperty()
  state: string;

  @ApiProperty()
  postalCode: string;

  @ApiProperty()
  country: string;

  @ApiProperty()
  createdAt: Date;

  @ApiProperty()
  updatedAt: Date;
}
