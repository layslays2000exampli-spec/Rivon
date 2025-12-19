# Rivonimport discord
from discord.ext import commands

intents = discord.Intents.default()
intents.message_content = True
intents.members = True

bot = commands.Bot(command_prefix='!', intents=intents)

@bot.event
async def on_ready():
    print(f'Logged in as {bot.user}')

# أمر البرودكاست: !bc رسالتك هنا
@bot.command()
@commands.has_permissions(administrator=True)
async def bc(ctx, *, message):
    for member in ctx.guild.members:
        if not member.bot:
            try:
                await member.send(message)
            except:
                continue
    await ctx.send("✅ تم إرسال البرودكاست لجميع الأعضاء.")

bot.run('ضع_التوكن_هنا')\
import discord
from discord.ext import commands

intents = discord.Intents.default()
intents.members = True  # ضروري لرسائل الترحيب وادارة الأعضاء

bot = commands.Bot(command_prefix="!", intents=intents)

# عند تشغيل البوت
@bot.event
async def on_ready():
    print(f"{bot.user} شغال!")

# رسالة ترحيب للأعضاء الجدد
@bot.event
async def on_member_join(member):
    channel = discord.utils.get(member.guild.text_channels, name="general")  # غير اسم القناة إذا أحببت
    if channel:
        await channel.send(f"أهلاً وسهلاً بك {member.mention} في السيرفر!")

# أمر مرح
@bot.command()
async def hello(ctx):
    await ctx.send(f"هلا {ctx.author.mention}! كيف حالك؟ 😄")

# أمر طرد عضو
@bot.command()
@commands.has_permissions(kick_members=True)
async def kick(ctx, member: discord.Member, *, reason=None):
    await member.kick(reason=reason)
    await ctx.send(f"{member.mention} تم طرده بنجاح!")

# أمر حظر عضو
@bot.command()
@commands.has_permissions(ban_members=True)
async def ban(ctx, member: discord.Member, *, reason=None):
    await member.ban(reason=reason)
    await ctx.send
